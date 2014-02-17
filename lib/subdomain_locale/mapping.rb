module SubdomainLocale
  class << self
    attr_accessor :mapping
  end

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
      locale and @repository.invert[locale.to_s] || locale.to_s
    end
  end
end
