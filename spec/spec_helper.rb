require 'simplecov'
SimpleCov.start

# Load the Sinatra app
require 'mollie-bank'

require 'rspec'
require 'webrat'
require 'rack/test'
require 'nokogiri'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webrat::Methods
  conf.include Webrat::Matchers
end

def app
  MollieBank::Application
end
