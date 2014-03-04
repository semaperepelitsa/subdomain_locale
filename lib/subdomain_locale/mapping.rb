module SubdomainLocale
  class << self
    attr_accessor :mapping
  end

  def self.default_fallback(locale)
    if I18n.locale_available?(locale)
      locale
    else
      I18n.default_locale
    end
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
      locale and @repository.invert.fetch(locale.to_s, locale.to_s).presence
    end
  end
end
