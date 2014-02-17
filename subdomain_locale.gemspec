# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "subdomain_locale"
  spec.version       = "0.1.1"
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
                        lib/subdomain_locale/mapping.rb
                        lib/subdomain_locale/railtie.rb
                        lib/subdomain_locale/url_for.rb
                        lib/subdomain_locale/version.rb
                        test/controller_test.rb
                        test/lib/i18n.rb
                        test/mapping_test.rb
                        test/url_for_test.rb
                        test/acceptance_test.rb
                      )
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n", "~> 0.2"
end
