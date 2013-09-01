require 'bundler'
require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*spec.rb'
end
