module SubdomainLocale
  class << self
    attr_accessor :mapping, :default_locale
  end

  def self.default_fallback(locale)
    if I18n.locale_available?(locale)
      locale
    else
      default_locale
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
      locale and @repository.invert.fetch(locale.to_s, locale.to_s).presence or false
    end
  end
end
