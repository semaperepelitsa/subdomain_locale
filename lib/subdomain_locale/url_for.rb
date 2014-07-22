module SubdomainLocale
  module UrlFor
    # Makes url_for(locale: 'ru') the same as url_for(subdomain: 'ru', only_path: false)
    # That way you can easily swap locale in subdomain with locale in the path.
    #
    # E. g. assuming you have <tt>scope ":locale"</tt> in your routes:
    #   url_for params.merge(locale: 'ru') # => /ru/current_path
    # After including this module:
    #   url_for params.merge(locale: 'ru') # => http://ru.example.com/current_path
    def url_for(options)
      options = options.dup
      if options.key?(:locale)
        # Locale specified, force full URL
        locale = options.delete(:locale)
        options[:subdomain] = options[:subdomain].subdomain_for(locale)
        options[:only_path] = false
      else
        options[:subdomain] = options[:subdomain].subdomain_for(current_locale)
      end

      super
    end

    def default_url_options
      super.merge({
        subdomain: request.env['subdomain_locale']
      })
    end

    def current_locale
      I18n.locale
    end
  end
end
