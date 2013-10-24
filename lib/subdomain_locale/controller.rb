module SubdomainLocale
  module Controller
    def self.included(base)
      base.before_filter :set_locale
    end

    private

    def set_locale
      I18n.locale = SubdomainLocale.mapping.locale_for(request.subdomain)
    end
  end
end
