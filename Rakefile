require "hoe"

Hoe.spec 'subdomain_locale' do
  developer 'Semyon Perepelitsa', 'sema@sema.in'
end

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
