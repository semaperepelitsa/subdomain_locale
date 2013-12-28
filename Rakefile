require "bundler/setup"
require "bundler/gem_tasks"
require "appraisal"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
