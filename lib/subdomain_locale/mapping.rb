module SubdomainLocale
  class Mapping
    def initialize(mapping)
      @repository = {}
      mapping.each do |subdomain, locale|
        @repository[subdomain] = locale.to_s
      end
    end

    def locale_for(subdomain)
      @repository[subdomain] || subdomain
    end

    def subdomain_for(locale)
      locale and @repository.invert.fetch(locale.to_s, locale.to_s).presence or false
    end
  end
end
