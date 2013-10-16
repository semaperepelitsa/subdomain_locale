require "subdomain_locale/version"
require "subdomain_locale/railtie" if defined?(Rails)

module SubdomainLocale
  class << self
    attr_accessor :mapping
  end
end
