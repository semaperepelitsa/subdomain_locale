# encoding: UTF-8
require_relative "test_helper"

class HelloControllerTest < ActionController::TestCase
  def test_links
    @request.host = "ru.example.com"
    get :world
    menu = css_select("menu a")
    assert_equal "http://example.com/", menu[0]["href"]
    assert_equal "http://en.example.com/", menu[1]["href"]
    assert_equal "http://example.com/",  menu[2]["href"]
    assert_equal "http://ua.example.com/",  menu[3]["href"]
    assert_equal "http://beta.example.com/",  menu[4]["href"]
  end

  def test_default
    @request.host = "example.com"
    get :world
    assert_response :ok
    assert_select "p", "Привет"
  end

  def test_direct
    @request.host = "en.example.com"
    get :world
    assert_response :ok
    assert_select "p", "Hello"
  end

  def test_custom
    @request.host = "ua.example.com"
    get :world
    assert_response :ok
    assert_select "p", "Привіт"
  end

  def test_locale_after_action
    @request.host = "ru.example.com"
    get :world
    assert_equal :en, I18n.locale
  end

  def test_other
    @request.host = "wtf.example.com"
    get :world
    assert_select "p", "Привет"
  end

  def test_url_for_subdomain_replacement_by_default
    assert Rails.application.config.current_locale_subdomain_in_url_for
  end
end

class HelloMailerTest < ActionController::TestCase
  def test_locale_domain
    mail = HelloMailer.world(:uk)
    assert_equal "http://ua.example.com/", mail.body.to_s.lines[3].chomp
  end

  # BetaMailer overrides default_url_options
  def test_custom_domain
    mail = BetaMailer.world(:uk)
    assert_equal "http://beta.example.com/", mail.body.to_s.lines[3].chomp
  end
end
