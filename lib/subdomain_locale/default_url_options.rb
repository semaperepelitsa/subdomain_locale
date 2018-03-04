module SubdomainLocale
  module DefaultUrlOptions
    def default_url_options
      super.merge({
        subdomain: subdomain_locales.subdomain_for(current_locale)
      })
    end

    def current_locale
      I18n.locale
    end
  end
end
