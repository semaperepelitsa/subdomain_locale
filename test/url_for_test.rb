require "minitest/autorun"
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "subdomain_locale/url_for"

class UrlForTest < MiniTest::Unit::TestCase
  module UrlFor
    def url_for(*args)
      @actual = args
    end
  end

  include UrlFor
  include SubdomainLocale::UrlFor

  def test_does_not_affect_if_there_is_no_locale
    url_for(foo: 'bar')
    assert_equal [{foo: 'bar'}], @actual
  end

  def test_does_not_affect_string_argument
    url_for('/bar')
    assert_equal ['/bar'], @actual
  end

  def test_replaces_locale_with_subdomain_and_forces_not_only_path
    url_for(foo: 'bar', locale: :ru)
    assert_equal [{foo: 'bar', subdomain: 'ru', only_path: false}], @actual
  end

  def test_replaces_locale_with_subdomain_and_overrides_only_path
    url_for(foo: 'bar', locale: :ru, only_path: true)
    assert_equal [{foo: 'bar', subdomain: 'ru', only_path: false}], @actual
  end

  def test_sets_subdomain_to_www_for_default_locale
    url_for(foo: 'bar', locale: :az)
    assert_equal [{foo: 'bar', subdomain: 'www', only_path: false}], @actual
  end
end
