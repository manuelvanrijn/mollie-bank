require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] = 'test'

# Load the Sinatra app
require 'mollie-bank'

require 'rspec'
require 'webrat'
require 'rack/test'
require 'nokogiri'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webrat::Methods
  conf.include Webrat::Matchers
end

def app
  MollieBank::Application
end
