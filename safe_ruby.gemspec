Gem::Specification.new do |s|
  s.name        = 'safe_ruby'
  s.version     = '1.0.1'
  s.date        = '2013-12-04'
  s.summary     = "Run untrusted ruby code in a safe environment"
  s.description = "Evaluates ruby code by writing it to a tempfile and spawning a child process. Uses a whitelist of methods and constants to keep, for example one cannot run system commands in the environment created by this gem. The environment created by the untrusted code does not leak out into the parent process."
  s.authors     = ["Uku Taht"]
  s.email       = 'uku.taht@gmail.com'
  s.files       = ["lib/safe_ruby.rb", "lib/constant_whitelist.rb", "lib/make_safe_code.rb", "lib/method_whitelist.rb", "lib/safe_ruby_runner.rb"]
  s.homepage    =
    'http://rubygems.org/gems/safe_ruby'
  s.license       = 'MIT'
  s.add_runtime_dependency 'childprocess', '>= 0.3.9'
  s.add_development_dependency 'rspec', '>= 2.14.1'
end