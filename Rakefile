gem "hoe", "~> 3.0"
require "hoe"

Hoe.spec 'subdomain_locale' do
  developer 'Semyon Perepelitsa', 'sema@sema.in'
  self.urls = %w(https://github.com/semaperepelitsa/subdomain_locale)
end

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
