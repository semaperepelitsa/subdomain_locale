require "minitest/autorun"
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
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

  def test_sets_locale
    assert_nil I18n.locale
    Controller.new.run
    assert_equal :ru, I18n.locale
  end
end
