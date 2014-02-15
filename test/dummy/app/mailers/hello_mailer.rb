class HelloMailer < ActionMailer::Base
  def world
    mail from: "app@example.com", to: "world@example.com", subject: "Hello, world!" do |f|
      f.text
    end
  end
end
