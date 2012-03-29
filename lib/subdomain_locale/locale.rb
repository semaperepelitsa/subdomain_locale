require "i18n"

module SubdomainLocale
  class Locale
    class << self
      # Sets I18n.locale based on passed subdomain.
      # Defaults to the I18n.default_locale if the subdomain isn't in I18n.available_locales
      #   I18n.default_locale = :az
      #   Locale.set('ru') # => :ru
      #   Locale.set('az') # => :az
      #   Locale.set('www')# => :az
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

    # Returns subdomain for the locale. If the locale is default, "www" is returned.
    #   I18n.default_locale = :az
    #   Locale.new(:ru).subdomain  # => 'ru'
    #   Locale.new(:az).subdomain  # => 'www'
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
