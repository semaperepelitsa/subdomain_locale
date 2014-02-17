require "isolate/now"
require "minitest/autorun"
require "subdomain_locale/mapping"

class MappingTest < MiniTest::Unit::TestCase
  include SubdomainLocale

  def setup
    @mapping = Mapping.new("ua" => :uk)
  end

  def test_custom
    assert_equal "uk", @mapping.locale_for("ua")
    assert_equal "ua", @mapping.subdomain_for(:uk)
  end

  def test_default
    assert_equal "ru", @mapping.locale_for("ru")
    assert_equal "ru", @mapping.subdomain_for(:ru)
  end

  def test_nil
    assert_nil @mapping.subdomain_for(nil)
  end
end
