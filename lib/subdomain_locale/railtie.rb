require "rails/railtie"

module SubdomainLocale
  class Railtie < ::Rails::Railtie

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
