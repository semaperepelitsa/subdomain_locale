require "subdomain_locale/locale"

module SubdomainLocale
  module Controller
    def self.included(base)
      base.before_filter :set_locale
    end

    private

    def set_locale
      Locale.set(request.subdomain)
    end
  end
end
