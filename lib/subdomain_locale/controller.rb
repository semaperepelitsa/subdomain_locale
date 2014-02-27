module SubdomainLocale
  module Controller
    def self.included(base)
      base.around_filter :set_locale
    end

    private

    def set_locale
      locale = SubdomainLocale.mapping.locale_for(request.subdomain)
      I18n.with_locale(locale) { yield }
    end
  end
end
