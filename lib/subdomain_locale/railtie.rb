require "rails/railtie"
require "subdomain_locale/url_for"
require "subdomain_locale/controller"

module SubdomainLocale
  class Railtie < ::Rails::Railtie

    initializer "subdomain_locale.url_helpers" do
      Rails.application.routes.url_helpers.send :include, SubdomainLocale::UrlFor
    end

    initializer "subdomain_locale.controller" do
      ActiveSupport.on_load :action_controller do
        include SubdomainLocale::Controller
      end
    end

  end
end
