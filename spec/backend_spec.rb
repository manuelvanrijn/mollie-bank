require 'spec_helper'

describe "backend" do
  it "should return the Mollie Bank when requesting /xml/ideal?a=banklist" do
    post '/xml/ideal?a=banklist'
    last_response.should be_ok
    xml = Nokogiri::Slop(last_response.body)

    xml.response.bank.bank_id.content.should == "0001"
    xml.response.bank.bank_name.content.should == "Mollie Bank"
  end
  it "should return the correct xml for /xml/ideal?a=fetch" do
    post '/xml/ideal?a=fetch&partnerid=1234&description=a&reporturl=http://test.com/report&returnurl=http://test.com/returnurl&amount=1000&bank_id=0001'
    xml = Nokogiri::Slop(last_response.body)

    xml.response.order.transaction_id.content.should_not be_blank
    xml.response.order.amount.content.should == "1000"
    xml.response.order.currency.content.should == "EUR"
    xml.response.order.URL.content.should contain "http://example.org/ideal?transaction_id="
    xml.response.order.message.content.should == "Your iDEAL-payment has successfully been setup. Your customer should visit the given URL to make the payment"
  end
  # it "should return the true if paid" do
  #   hash = Hash.new
  #   hash["987654"] = Hash.new
  #   hash["987654"]["paid"] = true
  #   last_response.set_cookie "storage=#{hash.to_json}"
  #   post '/xml/ideal?a=check&partnerid=1234&transaction_id=987654'
  #   last_response.should be_ok
  #  
  #   xml = Nokogiri::Slop(last_response.body)
  #   xml.response.order.payed.content.should == "true"
  # end
  it "should return the false not paid" do
    hash = Hash.new
    hash["987654"] = Hash.new
    hash["987654"]["paid"] = false
    #app.session[:storage] = hash.to_json
    app.set_storage(hash.to_json)
    post '/xml/ideal?a=check&partnerid=1234&transaction_id=987654'
    last_response.should be_ok
    puts last_response.body
    xml = Nokogiri::Slop(last_response.body)
    xml.response.order.payed.content.should == "false"
  end
end
