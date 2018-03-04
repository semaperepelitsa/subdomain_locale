module SubdomainLocale
  module UrlFor
    # Makes url_for(locale: 'ru') the same as url_for(subdomain: 'ru', only_path: false)
    # That way you can easily swap locale in subdomain with locale in the path.
    #
    # E. g. assuming you have <tt>scope ":locale"</tt> in your routes:
    #   url_for params.merge(locale: 'ru') # => /ru/current_path
    # After including this module:
    #   url_for params.merge(locale: 'ru') # => http://ru.example.com/current_path
    def url_for(options, *other)
      options = options.dup
      if options.key?(:locale)
        # Locale specified, force full URL
        locale = options.delete(:locale)
        options[:subdomain] = subdomain_locales.subdomain_for(locale)
        options[:only_path] = false
      end

      super(options, *other)
    end

    private

    def subdomain_locales
      SubdomainLocale.mapping
    end
  end
end
