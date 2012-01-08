module I18n
  class << self
    attr_accessor :locale

    def available_locales
      [:az, :ru, :en]
    end

    def default_locale
      :az
    end
  end
end
