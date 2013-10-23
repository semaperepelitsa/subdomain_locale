# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subdomain_locale/version'

Gem::Specification.new do |spec|
  spec.name          = "subdomain_locale"
  spec.version       = SubdomainLocale::VERSION
  spec.authors       = ["Semyon Perepelitsa"]
  spec.email         = ["sema@sema.in"]
  spec.description   = "Moves current locale into subdomain in your Rails app"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/semaperepelitsa/subdomain_locale"
  spec.license       = "MIT"

  spec.files         = %w(
                        Rakefile
                        Readme.md
                        lib/subdomain_locale.rb
                        lib/subdomain_locale/controller.rb
                        lib/subdomain_locale/locale.rb
                        lib/subdomain_locale/railtie.rb
                        lib/subdomain_locale/url_for.rb
                        lib/subdomain_locale/version.rb
                        test/controller_test.rb
                        test/lib/i18n.rb
                        test/locale_test.rb
                        test/url_for_test.rb
                      )
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "i18n", "~> 0.2"
end
