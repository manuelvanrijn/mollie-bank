module MollieBank
  class Application < Sinatra::Base
    helpers Sinatra::ContentFor
    register Sinatra::Namespace
    register Sinatra::Reloader

    set :static, true
    set :public_folder, File.expand_path('..', __FILE__)

    set :views, File.expand_path('../views/', __FILE__)
    set :haml, { :format => :html5 }

    enable :sessions unless test?

    # Displays a information page of the Mollie-Bank gem
    get '/' do
      haml :info
    end

    # Displays a bank page for finishing the transaction
    get '/ideal' do
      transaction_id = params[:transaction_id]
      description = params[:description]
      reporturl = params[:reporturl]
      returnurl = params[:returnurl]
      amount = params[:amount]

      if transaction_id.nil? or description.nil? or reporturl.nil? or returnurl.nil? or amount.nil?
        haml :html_error, :locals => { :message => "To few params have been supplied (expected to retrieve 'transaction_id', 'description', 'reporturl', 'returnurl' and 'amount')" }
      else
        int, frac = ("%.2f" % (amount.to_f/100)).split('.')
        amount = "#{int},#{frac}"

        hash = get_storage
        hash["#{transaction_id}"]["reporturl"] = reporturl
        hash["#{transaction_id}"]["returnurl"] = returnurl
        set_storage(hash)

        url_path = request.url.split('/ideal?transaction_id=')[0]

        haml :bank_page, :locals => {
          :transaction_id => transaction_id,
          :amount => amount,
          :reporturl => reporturl,
          :returnurl => returnurl,
          :description => description,
          :url_path => url_path
        }
      end
    end

    # Background page that sends the paid = true or paid = false to the report url
    get '/payment' do
      transaction_id = params[:transaction_id]
      paid = params[:paid] == "true" ? true : false

      if transaction_id.nil? or paid.nil?
        haml :html_error, :locals => { :message => "To few params have been supplied" }
      else
        hash = get_storage
        hash["#{transaction_id}"]['paid'] = paid
        reporturl = hash["#{transaction_id}"]["reporturl"]
        returnurl = hash["#{transaction_id}"]["returnurl"]
        set_storage(hash)

        begin
          reporturl = URI("#{reporturl}?transaction_id=#{transaction_id}")
          res = Net::HTTP.get(reporturl)
        rescue
        end

        redirect returnurl
      end
    end

    namespace '/xml' do
      post '/ideal' do
        content_type 'text/xml'
        case params[:a]
        when "banklist"
          haml :banklist, :layout => false
        when "fetch"
          return error(-2) unless params.has_key?("partnerid")
          return error(-7) unless params.has_key?("description")
          return error(-3) unless params.has_key?("reporturl")
          return error(-12) unless params.has_key?("returnurl")
          return error(-4) unless params.has_key?("amount")
          return error(-14) unless params[:amount].to_i > 118
          return error(-6) unless params.has_key?("bank_id")

          partnerid = params[:partnerid]
          description = params[:description]
          reporturl = params[:reporturl]
          returnurl = params[:returnurl]
          amount = params[:amount]
          bank_id = params[:bank_id]

          transaction_id = UUID.new.generate.gsub('-', '')

          hash = get_storage
          hash["#{transaction_id}"] = {}
          hash["#{transaction_id}"]['paid'] = false
          set_storage(hash)

          url_path = request.url.split('/xml/ideal')[0]

          haml :fetch, :layout => false, :locals => {
            :transaction_id => transaction_id,
            :amount => amount,
            :reporturl => reporturl,
            :returnurl => returnurl,
            :description => description,
            :url_path => url_path
          }
        when "check"
          return error(-11) unless params.has_key?("partnerid")
          return error(-8) unless params.has_key?("transaction_id")

          transaction_id = params[:transaction_id]
          return error(-10) unless get_storage.has_key?("#{transaction_id}")

          is_paid = get_storage["#{transaction_id}"]['paid']

          haml :check, :layout => false, :locals => {
            :transaction_id => transaction_id,
            :is_paid => is_paid
          }
        else
          error(-1)
        end
      end
    end

    def error(code)
      # Mollie codes taken from https://www.mollie.nl/support/documentatie/betaaldiensten/ideal/en/
      errors = []
      errors[1] = "Did not receive a proper input value."
      errors[2] = "A fetch was issued without specification of 'partnerid'."
      errors[3] = "A fetch was issued without (proper) specification of 'reporturl'."
      errors[4] = "A fetch was issued without specification of 'amount'."
      errors[5] = "A fetch was issued without specification of 'bank_id'."
      errors[6] = "A fetch was issues without specification of a known 'bank_id'."
      errors[7] = "A fetch was issued without specification of 'description'."
      errors[8] = "A check was issued without specification of transaction_id."
      errors[9] = "Transaction_id contains illegal characters. (Logged as attempt to mangle)."
      errors[10] = "This is an unknown order."
      errors[11] = "A check was issued without specification of your partner_id."
      errors[12] = "A fetch was issued without (proper) specification of 'returnurl'."
      errors[13] = "This amount is only permitted when iDEAL contract is signed and sent to Mollie."
      errors[14] = "Minimum amount for an ideal transaction is 1,18 EUR."
      errors[15] = "A fetch was issued for an account which is not allowed to accept iDEAL payments (yet)."
      errors[16] = "A fetch was issued for an unknown or inactive profile."

      haml :error, :layout => false, :locals => {
        :type => "error",
        :code => code,
        :message => errors[code*-1]
      }
    end

  private
    def get_storage
      session[:storage] == nil ? {} : JSON.parse(session[:storage])
    end

    def set_storage(hash)
      session[:storage] = hash.to_json
    end
  end
end
