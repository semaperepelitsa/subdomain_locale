ENV["RAILS_ENV"] = "test"

require "isolate/now"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "minitest/autorun"
require "rails/test_help"
Rails.backtrace_cleaner.remove_silencers!

# Mail 2.5 gives warnings, fixed in 2.6
require "mail"
Mail::Sendmail
##

$VERBOSE = true
