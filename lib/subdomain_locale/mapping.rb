module SubdomainLocale
  class << self
    attr_accessor :mapping
  end

  class Mapping
    def initialize(mapping)
      @repository = {}
      mapping.each do |subdomain, locale|
        @repository[subdomain.to_s.downcase] = locale.to_sym
      end
    end

    def locale_for(subdomain)
      @repository.fetch(subdomain)
    end

    def subdomain_for(locale)
      return unless locale.respond_to?(:to_sym)
      @repository.invert.fetch(locale.to_sym)
    end
  end
end
