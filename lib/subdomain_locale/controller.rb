module SubdomainLocale
  module Controller
    def self.included(base)
      base.around_action :set_locale
    end

    private

    def set_locale
      locale = SubdomainLocale.mapping.locale_for(request.subdomain)
      locale = SubdomainLocale.default_fallback(locale)
      I18n.with_locale(locale) { yield }
    end
  end
end
