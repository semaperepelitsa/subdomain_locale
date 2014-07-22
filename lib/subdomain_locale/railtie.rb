require "rails/railtie"

module SubdomainLocale
  class Railtie < ::Rails::Railtie
    config.subdomain_locale = {}
    config.default_subdomain = "" # or "www"
    config.default_locale = nil

    # Execute after all application initializers, I18n is often configured there.
    initializer "subdomain_locale.middleware" do |app|
      require "subdomain_locale/middleware"
      default = { app.config.default_subdomain => app.config.default_locale }
      mapping = default.merge(app.config.subdomain_locale)
      app.middleware.use SubdomainLocale::Middleware, mapping, app.config.default_locale
    end

    initializer "subdomain_locale.url_helpers" do
      require "subdomain_locale/url_for"
      Rails.application.routes.extend SubdomainLocale::UrlFor
    end

  end
end
