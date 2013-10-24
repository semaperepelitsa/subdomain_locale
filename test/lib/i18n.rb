module I18n
  class << self
    attr_accessor :locale

    def available_locales
      [:az, :ru, :en, :"en-US"]
    end

    def default_locale
      :az
    end
  end
end
