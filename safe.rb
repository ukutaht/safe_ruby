require_relative 'method_whitelist'
require_relative 'constant_whitelist'

class SafeRuby
  def self.eval(code)
    @@safe_binding ||= get_safe_binding 
    Kernel.eval(code, @@safe_binding)
  end

  private

  def self.get_safe_binding
    mybinding = binding
    Kernel.eval(MAKESAFE, mybinding)
    return mybinding
  end
end