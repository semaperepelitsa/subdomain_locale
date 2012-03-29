require "subdomain_locale/locale"

module SubdomainLocale
  module UrlFor
    def url_for(options=nil)
      if options.is_a?(Hash) and locale = options.delete(:locale)
        options[:subdomain] = Locale.new(locale).subdomain
        options[:only_path] = false
      end

      super
    end
  end
end
