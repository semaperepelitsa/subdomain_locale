require "rake/testtask"
require "bundler/gem_tasks"

Rake::TestTask.new do |t|
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true

  # The default rake test loader is messing up $LOAD_PATH
  t.loader = :direct
  t.libs << '.'
end

task "test:all" do
  sh({"RAILS" => "5.1"}, $0, "test")
  puts
  sh({"RAILS" => "5.0"}, $0, "test")
end

task :default => :test
