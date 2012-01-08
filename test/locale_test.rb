require "test_helper"

class LocaleTest < MiniTest::Unit::TestCase
  include SubdomainLocale

  def test_sets_locale
    Locale.set("ru")
    assert_equal :ru, I18n.locale
  end

  def test_sets_default_locale_for_nil
    Locale.set(nil)
    assert_equal :az, I18n.locale
  end

  def test_subdomain
    assert_equal "ru", Locale.new(:ru).subdomain
  end

  def test_default_subdomain
    assert_equal "www", Locale.new(:az).subdomain
  end

  def test_default?
    assert Locale.new(:az).default?
  end

  def test_not_default?
    refute Locale.new(:ru).default?
  end
end
