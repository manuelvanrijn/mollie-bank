# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mollie-bank/version"

Gem::Specification.new do |s|
  s.name        = "mollie-bank"
  s.version     = MollieBank::VERSION
  s.authors     = ["Manuel van Rijn"]
  s.email       = ["manuel@manuelles.nl"]
  s.homepage    = ""
  s.summary     = %q{Write a gem summary}
  s.description = %q{Write a gem description}

  s.rubyforge_project = "mollie-bank"

  s.files               = `git ls-files`.split("\n")
  s.test_files          = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables         = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable  = 'mollie-bank'
  s.require_paths       = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "sinatra-reloader"

  s.add_dependency "rake", "~> 0.9.0"
  s.add_dependency "uuid", "~> 2.3"
  s.add_dependency "haml", "~> 3.0"
  s.add_dependency "sinatra", "~> 1.3.0"
  s.add_dependency "sinatra-contrib", "~> 1.3.1"
end
