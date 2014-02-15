require "rake/testtask"
require "isolate/now"
require "bundler/gem_tasks"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true
end

task "test:all" do
  sh "rake test"
  puts
  sh "rake test RAILS=3"
end

task :default => :test
