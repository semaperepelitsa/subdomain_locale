module SubdomainLocale
  class Locale
    class << self
      def set(subdomain)
        I18n.locale = find(subdomain).to_sym
      end

      private

      def find(subdomain)
        new(subdomain).valid || default
      end

      def default
        new(I18n.default_locale)
      end
    end

    def initialize(str)
      @str = str.to_s
    end

    def to_s
      @str
    end

    def to_sym
      @sym ||= @str.to_sym
    end

    def subdomain
      if default?
        'www'
      else
        to_s
      end
    end

    def default?
      I18n.default_locale.to_sym == self.to_sym
    end

    def valid
      self if valid?
    end

    def valid?
      I18n.available_locales.include?(self.to_sym)
    end
  end
end
