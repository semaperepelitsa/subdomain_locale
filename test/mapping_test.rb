require "bundler/setup"
require "minitest/autorun"
require "subdomain_locale/mapping"

class MappingTest < MiniTest::Unit::TestCase
  include SubdomainLocale

  def subject
    Mapping.new("ru" => :ru)
  end

  def test_locale_for_existed_subdomain
    assert_equal :ru, subject.locale_for("ru")
  end

  def test_locale_for_not_existed_subdomain
    assert_raises KeyError do
      subject.locale_for("en")
    end
  end

  def test_locale_for_nil
    assert_raises KeyError do
      subject.locale_for(nil)
    end
  end

  def test_locale_for_with_string_mapping
    subject = Mapping.new("ru" => "ru")
    assert_equal :ru, subject.locale_for("ru")
  end

  def test_locale_for_compound_locale
    subject = Mapping.new("en-US" => :"en-US")
    assert_equal :"en-US", subject.locale_for("en-us")
  end

  def test_subdomain_for_existed_locale
    assert_equal "ru", subject.subdomain_for(:ru)
  end

  def test_subdomain_for_existed_string_locale
    assert_equal "ru", subject.subdomain_for("ru")
  end

  def test_subdomain_for_not_existed_locale
    assert_raises KeyError do
      subject.subdomain_for(:en)
    end
  end

  def test_subdomain_for_nil
    assert_nil subject.subdomain_for(nil)
  end

  def test_subdomain_for_compound_locale
    subject = Mapping.new("en-US" => "en-US")
    assert_equal "en-us", subject.subdomain_for(:"en-US")
  end
end
