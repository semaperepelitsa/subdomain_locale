$LOAD_PATH.unshift File.expand_path('..', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "minitest/unit"
require "subdomain_locale"
require "i18n_stub"
MiniTest::Unit.autorun
