require 'spec_helper'

describe "frontend" do
  it "should show the home page when browsing to /" do
    get '/'
    last_response.should be_ok
    last_response.body.should contain "Information page"
    last_response.body.should contain "Step 1"
    last_response.body.should contain "Step 2"
    last_response.body.should contain "Step 3"
  end
  it "should who me an error when browsing to /ideal without parameters" do
    get '/ideal'
    last_response.should be_ok
    last_response.body.should contain "Oh snap! You got an error!"
    last_response.body.should contain "To few params have been supplied"
  end
  it "should show me the Mollie Bank page to make payment or not when browsing to /ideal with parameters" do
    # @@storage = Hash.new
    #     @@storage["987654"] = Hash.new
    #     @@storage["987654"]['paid'] = false
    # 
    #     get '/ideal?transaction_id=987654&amount=1000&reporturl=report&returnurl=return&description=a_description'
    #     last_response.should be_ok
    #     last_response.body.should contain "Pay time!"
    #     last_response.body.should contain "YES, I wish to pay"
    #     last_response.body.should contain "NO, I do not want to pay"
    #     last_response.body.should contain "10,00 EUR"
    #     last_response.body.should contain "a_description"
    #     last_response.body.should contain "report"
    #     last_response.body.should contain "return"
    #     last_response.body.should contain "987654"
  end
  it "should show an html error when not all parameter are supplied for /payment" do
    get '/payment'
    last_response.should be_ok
    last_response.body.should contain "Oh snap! You got an error!"
    last_response.body.should contain "To few params have been supplied"
  end
  it "should store the correct values" do
    # @@storage = Hash.new
    #     @@storage["987654"] = Hash.new
    #     @@storage["987654"]['paid'] = false
    #     @@storage["987654"]['reporturl'] = '/report.html'
    #     @@storage["987654"]['returnurl'] = '/return.html'
    # 
    #     get '/payment?transaction_id=987654&paid=true'
    #     last_response.should be_redirect
    #     follow_redirect!
    #     last_request.url.should == 'http://example.org/return.html'
  end
end
