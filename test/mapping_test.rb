require_relative "test_helper"

class MappingTest < MiniTest::Unit::TestCase
  include SubdomainLocale

  def setup
    @mapping = Mapping.new("ua" => :uk, "" => :en)
  end

  def test_custom
    assert_equal "uk", @mapping.locale_for("ua")
    assert_equal "ua", @mapping.subdomain_for(:uk)
  end

  def test_default
    assert_equal "ru", @mapping.locale_for("ru")
    assert_equal "ru", @mapping.subdomain_for(:ru)
  end

  def test_no_subdomain
    # request.subdomain returns "" for test.host
    assert_equal "en", @mapping.locale_for("")

    # url_for(subdomain: "") => ".test.host"
    # url_for(subdomain: nil) => "test.host" in Rails 4, "current.test.host" in Rails 3
    # url_for(subdomain: false) => "test.host"
    assert_equal false, @mapping.subdomain_for(:en)
  end

  def test_nil
    assert_equal false, @mapping.subdomain_for(nil)
  end
end
