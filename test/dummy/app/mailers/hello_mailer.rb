class HelloMailer < ActionMailer::Base
  def world(locale)
    I18n.with_locale(locale) do
      mail from: "app@example.com", to: "world@example.com", subject: "Hello, world!" do |f|
        f.text
      end
    end
  end
end
