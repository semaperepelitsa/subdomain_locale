require "rails/railtie"

module SubdomainLocale
  class Railtie < ::Rails::Railtie
    config.subdomain_locales = {}

    config.after_initialize do |app|
      require "subdomain_locale/mapping"
      mapping = default_mapping.merge(app.config.subdomain_locales)
      SubdomainLocale.mapping = Mapping.new(mapping)
    end

    initializer "subdomain_locale.url_helpers" do
      require "subdomain_locale/url_for"
      Rails.application.routes.url_helpers.send :include, SubdomainLocale::UrlFor
    end

    initializer "subdomain_locale.controller" do
      ActiveSupport.on_load :action_controller do
        require "subdomain_locale/controller"
        include SubdomainLocale::Controller
      end
    end

    protected

    def self.default_mapping
      I18n.available_locales.each_with_object({}) do |locale, memo|
        memo[locale] = locale
      end.merge("www" => I18n.default_locale)
    end

  end
end
