# encoding: UTF-8
ENV["RAILS_ENV"] = "test"

require "bundler/setup"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "minitest/autorun"
require "rails/test_help"
Rails.backtrace_cleaner.remove_silencers!

class HelloMailerTest < ActionController::TestCase
  def test
    mail = I18n.with_locale(:ru) { HelloMailer.world }
    assert_equal "http://ru.example.com/", mail.body.to_s.lines[3].chomp
  end
end
