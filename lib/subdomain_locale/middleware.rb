require "subdomain_locale/mapping"

module SubdomainLocale
  class Middleware
    def initialize app, mapping, default_locale = nil
      @app = app
      @mapping = Mapping.new(mapping)
      @default_locale = default_locale || I18n.default_locale
    end

    def call env
      request = ActionDispatch::Request.new(env)
      locale = @mapping.locale_for(request.subdomain)
      locale = default_fallback(locale)
      I18n.with_locale(locale) { @app.call(env) }
    end

    private

    def default_fallback(locale)
      if I18n.locale_available?(locale)
        locale
      else
        @default_locale
      end
    end
  end
end
