require "bundler/gem_tasks"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new("spec")

require "yard"
YARD::Rake::YardocTask.new do |t|
  t.options += ["--title", "Mollie Bank #{MollieBank::VERSION} Documentation"]
end
