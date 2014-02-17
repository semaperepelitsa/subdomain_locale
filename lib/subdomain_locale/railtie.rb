require "rails/railtie"

module SubdomainLocale
  class Railtie < ::Rails::Railtie
    config.subdomain_locale = {}

    config.after_initialize do |app|
      require "subdomain_locale/mapping"
      mapping = { "www" => I18n.default_locale }.merge(app.config.subdomain_locale)
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

  end
end
