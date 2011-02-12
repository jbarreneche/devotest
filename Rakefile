require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = %w[lib app]
  t.pattern = "test/**/*_test.rb"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

desc 'Run all test suites'
task :default => [:test, :spec]