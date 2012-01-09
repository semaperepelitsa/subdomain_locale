require "subdomain_locale/railtie" if defined?(Rails)

module SubdomainLocale
  VERSION = "0.0.2"
  autoload :UrlFor,     "subdomain_locale/url_for"
  autoload :Controller, "subdomain_locale/controller"
  autoload :Locale,     "subdomain_locale/locale"
  autoload :Railtie,    "subdomain_locale/railtie"
end
