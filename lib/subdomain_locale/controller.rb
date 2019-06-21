module SubdomainLocale
  module Controller
    class SetLocaleFilter
      def self.around(controller)
        locale = SubdomainLocale.mapping.locale_for(controller.request.subdomain)
        locale = SubdomainLocale.default_fallback(locale)
        I18n.with_locale(locale) { yield }
      end
    end

    def self.included(base)
      base.around_action SetLocaleFilter
    end
  end
end
