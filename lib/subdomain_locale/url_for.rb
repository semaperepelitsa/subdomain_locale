require "subdomain_locale/locale"

module SubdomainLocale
  module UrlFor
    # Makes url_for(locale: 'ru') the same as url_for(subdomain: 'ru', only_path: false)
    # That way you can easily swap locale in subdomain with locale in the path.
    #
    # E. g. assuming you have <tt>scope ":locale"</tt> in your routes:
    #   url_for params.merge(locale: 'ru') # => /ru/current_path
    # After including this module:
    #   url_for params.merge(locale: 'ru') # => http://ru.example.com/current_path
    def url_for(options=nil)
      if options.is_a?(Hash) and options.has_key?(:locale)
        options = options.dup
        locale = options.delete(:locale)
        options[:subdomain] = Locale.new(locale).subdomain
        options[:only_path] = false
      end

      super
    end
  end
end
