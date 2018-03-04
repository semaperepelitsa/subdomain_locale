require "rails/railtie"

module SubdomainLocale
  class Railtie < ::Rails::Railtie
    config.subdomain_locale = {}
    config.default_subdomain = "" # or "www"
    config.default_locale = nil
    config.current_locale_subdomain_in_url_for = true

    # Execute after all application initializers, I18n is often configured there.
    config.after_initialize do |app|
      require "subdomain_locale/mapping"
      SubdomainLocale.default_locale = app.config.default_locale || I18n.default_locale

      default = { app.config.default_subdomain => SubdomainLocale.default_locale }
      mapping = default.merge(app.config.subdomain_locale)
      SubdomainLocale.mapping = Mapping.new(mapping)
    end

    initializer "subdomain_locale.url_helpers" do
      require "subdomain_locale/url_for"
      Rails.application.routes.extend SubdomainLocale::UrlFor
      if Rails.application.config.current_locale_subdomain_in_url_for
        require "subdomain_locale/default_url_options"
        Rails.application.routes.extend SubdomainLocale::DefaultUrlOptions
      end
    end

    initializer "subdomain_locale.controller" do
      ActiveSupport.on_load :action_controller do
        require "subdomain_locale/controller"
        include SubdomainLocale::Controller
      end
    end

  end
end
