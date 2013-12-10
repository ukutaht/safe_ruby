Safe Ruby
=========

Safe Ruby provides a way to run untrusted ruby code outside of the current process in a safe environment.
Creating this environment is largery based on jruby sandbox, whitelisting the methods one can use on potentially
dangerous classes. Constants are also whitelisted, eliminating some core ruby functionality such as spawning
another process.

Getting Started
==============

Run `gem install safe_ruby` in your terminal, then `require 'safe_ruby'` in your app and you're ready to go.

Examples
========

Evaluating ruby code

```ruby
  SafeRuby.eval('[1,2,3].map{ |n| n + 1 }')    #=> [2, 3, 4]
  
  SafeRuby.eval('system("rm *")')              #=> system is unavailable
  
  SafeRuby.eval('Kernel.abort')                #=> undefined method `abort' for Kernel:Module
```

Default timeout for evaluating is 5 seconds, but this can be specified.

```ruby
  SafeRuby.eval('loop{}')                      #<ChildProcess::TimeoutError: process still alive after 5 seconds>
  
  SafeRuby.eval('loop{}', timeout: 1)          #<ChildProcess::TimeoutError: process still alive after 1 seconds>
```

This library was built for a codeacademy-style tutoring app, so checking answers is built into the SafeRuby class

```ruby
  SafeRuby.check('[1,2,3].map{ |n| n + 1 }', '[2,3,4]')  #=> true
```

In this example, the second argument(expected answer) can also be untrusted, it will be run safely. 
