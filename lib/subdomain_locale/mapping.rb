module SubdomainLocale
  class Mapping
    def initialize(mapping)
      @repository = {}
      mapping.each do |subdomain, locale|
        @repository[subdomain.to_s.downcase] = locale.to_sym
      end
    end

    def locale_for(subdomain)
      @repository[subdomain]
    end

    def subdomain_for(locale)
      return unless locale.respond_to?(:to_sym)
      @repository.invert[locale.to_sym]
    end
  end
end
