require "bundler/setup"
require "minitest/autorun"
require "lib/i18n"
require "subdomain_locale"
require "subdomain_locale/controller"

class ControllerTest < MiniTest::Unit::TestCase
  class Controller
    class Request
      def subdomain
        "ru"
      end
    end

    def self.before_filter(sym)
      @@before_filters ||= []
      @@before_filters << sym
    end

    def self.before_filters
      @@before_filters
    end

    def run
      @@before_filters.each{ |sym| send(sym) }
    end

    def request
      Request.new
    end

    include SubdomainLocale::Controller
  end

  def setup
    I18n.locale = nil
  end

  def teardown
    SubdomainLocale.mapping = nil
    I18n.locale = nil
  end

  def test_sets_locale
    mapping = MiniTest::Mock.new
    mapping.expect(:locale_for, :ru, ["ru"])
    SubdomainLocale.mapping = mapping
    Controller.new.run
    assert_equal :ru, I18n.locale
    mapping.verify
  end
end
