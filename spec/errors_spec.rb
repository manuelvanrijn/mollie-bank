require 'spec_helper'

describe "errors" do
  describe "invalid /xml/ideal?a=" do
    it "should return an error -1" do
      post '/xml/ideal', {
        :a => 'unknown'
      }
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-1"
      xml.response.item.message.content.should eq "Did not receive a proper input value."
    end
  end
  describe "/xml/ideal?a=fetch" do
    it "should return error -2  if partnerid isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :description => 'description',
        :reporturl => 'http://example.org/report',
        :returnurl => 'http://example.org/return',
        :amount => '1000',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-2"
      xml.response.item.message.content.should eq "A fetch was issued without specification of 'partnerid'."
    end
    it "should return error -7  if description isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :reporturl => 'http://example.org/report',
        :returnurl => 'http://example.org/return',
        :amount => '1000',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-7"
      xml.response.item.message.content.should eq "A fetch was issued without specification of 'description'."
    end
    it "should return error -3  if reporturl isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :description => 'description',
        :returnurl => 'http://example.org/return',
        :amount => '1000',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-3"
      xml.response.item.message.content.should eq "A fetch was issued without (proper) specification of 'reporturl'."
    end
    it "should return error -12 if returnurl isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :description => 'description',
        :reporturl => 'http://example.org/report',
        :amount => '1000',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-12"
      xml.response.item.message.content.should eq "A fetch was issued without (proper) specification of 'returnurl'."
    end
    it "should return error -4  if amount isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :description => 'description',
        :reporturl => 'http://example.org/report',
        :returnurl => 'http://example.org/return',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-4"
      xml.response.item.message.content.should eq "A fetch was issued without specification of 'amount'."
    end
    it "should return error -14 if amount is to low" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :description => 'description',
        :reporturl => 'http://example.org/report',
        :returnurl => 'http://example.org/return',
        :amount => '100',
        :bank_id => '0001'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-14"
      xml.response.item.message.content.should eq "Minimum amount for an ideal transaction is 1,18 EUR."
    end
    it "should return error -6  if bank_id isn't provided" do
      post '/xml/ideal', {
        :a => 'fetch',
        :partnerid => '1234',
        :description => 'description',
        :reporturl => 'http://example.org/report',
        :returnurl => 'http://example.org/return',
        :amount => '1000'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-6"
      xml.response.item.message.content.should eq "A fetch was issues without specification of a known 'bank_id'."
    end
  end
  describe "/xml/ideal?a=check" do
    it "should return error -11 if partnerid isn't provided" do
      post '/xml/ideal', {
        :a => 'check',
        :transaction_id => '1'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-11"
      xml.response.item.message.content.should eq "A check was issued without specification of your partner_id."
    end
    it "should return error -8  if transaction_id isn't provided" do
      post '/xml/ideal', {
        :a => 'check',
        :partnerid => '1'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-8"
      xml.response.item.message.content.should eq "A check was issued without specification of transaction_id."
    end
    it "should return error -10 if transaction_id is unknown" do
      post '/xml/ideal', {
        :a => 'check',
        :partnerid => '1234',
        :transaction_id => '1234'
      }
      last_response.should be_ok
      xml = Nokogiri::Slop(last_response.body)
      xml.response.item["type"].should eq "error"

      xml.response.item.errorcode.content.should eq "-10"
      xml.response.item.message.content.should eq "This is an unknown order."
    end
  end
end
