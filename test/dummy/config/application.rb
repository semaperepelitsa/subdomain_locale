require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Dummy
  class Application < Rails::Application
    config.i18n.default_locale = :en
    config.i18n.available_locales = :en, :ru, :uk

    config.subdomain_locales["ua"] = :uk

    config.encoding = "utf-8"
  end
end
