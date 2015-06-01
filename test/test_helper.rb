ENV["RAILS_ENV"] = "test"

require "isolate/now"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "minitest/autorun"
require "rails/test_help"
Rails.backtrace_cleaner.remove_silencers!

$VERBOSE = true
