# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mollie-bank/version"

Gem::Specification.new do |s|
  s.name        = "mollie-bank"
  s.version     = MollieBank::VERSION
  s.authors     = ["Manuel van Rijn"]
  s.email       = ["manuel@manuelles.nl"]
  s.homepage    = "https://github.com/manuelvanrijn/mollie-bank"
  s.summary     = %q{Mollie Bank server to make Mollie iDeal payments on your local machine}
  s.description = %q{A small sinatra server that supports all the actions Mollie iDeal API needs to make a payment. Now you can test your transactions on you local machine without having to make portforwards}

  s.rubyforge_project = "mollie-bank"

  s.files               = `git ls-files`.split("\n")
  s.test_files          = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables         = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable  = 'mollie-bank'
  s.require_paths       = ["lib"]

  s.add_development_dependency "sinatra-reloader"
  s.add_development_dependency "rspec"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "webrat"
  s.add_development_dependency "redcarpet"
  s.add_development_dependency "yard"
  s.add_development_dependency "yard-sinatra"
  s.add_development_dependency "simplecov"

  s.add_dependency "rake", "> 0.9.0"
  s.add_dependency "json", "> 1.0.0"
  s.add_dependency "uuid", "> 1.0"
  s.add_dependency "haml", "> 3.0"
  s.add_dependency "sinatra", "~> 1.3.0"
  s.add_dependency "sinatra-contrib", "~> 1.3.1"
end
