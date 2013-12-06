require 'childprocess'
require_relative 'method_whitelist'
require_relative 'constant_whitelist'
require_relative 'make_safe_code'
require_relative 'safe_ruby_runner'

class SafeRuby
	VERSION = "0.0.1"
end
SafeRuby.eval('(1..100000).map {|n| n**100}')