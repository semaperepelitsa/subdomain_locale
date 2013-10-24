# encoding: utf-8
# https://github.com/jonleighton/focused_controller/blob/master/test/acceptance/app_test.rb

require "bundler/setup"
require "minitest/autorun"
require "capybara/webkit"
require "socket"
require "action_pack/version"

class AcceptanceTest < MiniTest::Unit::TestCase
  def port
    @port ||= begin
      server = TCPServer.new('127.0.0.1', 0)
      port   = server.addr[1]
    ensure
      server.close if server
    end
  end

  def url(string)
    "http://#{string}:#{port}"
  end

  def app_root
    File.expand_path("../dummy", __FILE__)
  end

  def within_test_app
    Bundler.with_clean_env do
      Dir.chdir(app_root) do
        begin
          prev_gemfile, ENV['BUNDLE_GEMFILE'] = ENV['BUNDLE_GEMFILE'], "#{app_root}/Gemfile"
          prev_rubyopt, ENV['RUBYOPT']        = ENV['RUBYOPT'], nil
          ENV['RAILS_VERSION'] = ActionPack::VERSION::STRING
          yield
        ensure
          ENV['BUNDLE_GEMFILE'] = prev_gemfile
          ENV['RUBYOPT']        = prev_rubyopt
        end
      end
    end
  end

  def run_without_bundle_exec(command)
    within_test_app do
      `#{command}`
      assert_equal 0, $?
    end
  end

  def read_output(stream)
    read = IO.select([stream], [], [stream], 0.1)
    output = ""
    loop { output << stream.read_nonblock(1024) } if read
    output
  rescue Errno::EAGAIN, Errno::EWOULDBLOCK, EOFError
    output
  end

  # This spawns a server process to run the app under test,
  # and then waits for it to successfully come up so we can
  # actually run the test.
  def start_server
    within_test_app do
      IO.popen("bundle exec rails s -p #{port} -e test 2>&1") do |out|
        begin
          start   = Time.now
          started = false
          output  = ""
          timeout = 60.0

          while !started && !out.eof? && Time.now - start <= timeout
            output << read_output(out)
            sleep 0.1

            begin
              TCPSocket.new('127.0.0.1', port)
            rescue Errno::ECONNREFUSED
            else
              started = true
            end
          end

          raise "Server failed to start:\n#{output}" unless started

          yield
        ensure
          Process.kill('KILL', out.pid)
          File.delete("tmp/pids/server.pid")
        end
      end
    end
  end

  def s
    @s ||= Capybara::Session.new(:webkit, nil)
  end

  def setup
    Capybara.run_server = false
    Capybara.app_host   = url("127.0.0.1")
    run_without_bundle_exec "bundle check >/dev/null || bundle update >/dev/null"
  end

  def test_it_switches_locale
    start_server do
      s.visit url("lvh.me")
      assert s.has_content? "Hello"

      s.click_link "English"
      assert_equal "http://www.lvh.me", s.current_host
      assert s.has_content? "Hello"

      s.click_link "Russian"
      assert_equal "http://ru.lvh.me", s.current_host
      assert s.has_content? "Привет"

      s.click_link "Ukrainian"
      assert_equal "http://ua.lvh.me", s.current_host
      assert s.has_content? "Привіт"
    end
  end
end
