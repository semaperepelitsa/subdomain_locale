# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "subdomain_locale"
  spec.version       = "0.1.1"
  spec.authors       = ["Semyon Perepelitsa"]
  spec.email         = ["sema@sema.in"]
  spec.description   = "Moves current locale into subdomain in your Rails app"
  spec.homepage      = "https://github.com/semaperepelitsa/subdomain_locale"
  spec.license       = "MIT"

  spec.files         = File.read("Manifest.txt").split("\n")
  spec.test_files    = spec.files.grep(%r{^test/})

  spec.add_dependency "i18n", "~> 0.2"
end
