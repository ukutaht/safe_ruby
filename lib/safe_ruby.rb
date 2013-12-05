require_relative 'method_whitelist'
require_relative 'constant_whitelist'
require_relative 'make_safe_code'
require 'childprocess'

class SafeRuby
  def initialize(code)
    @code = code
  end

  def self.eval(code)
    new(code).eval
  end

  def self.check(code, expected)
    eval(code) == eval(expected)
  end

  def eval
    temp = build_tempfile
    read, write = IO.pipe
    # readerr, writeerr = IO.pipe
    ChildProcess.build("ruby", temp.path).tap do |process|
      process.io.stdout = write
      process.io.stderr = write
      process.start
      process.wait
      write.close
    end

    data = read.read
    p data
    Marshal.load(data)
    # if data.empty?
    #   readerr.read
    # else
    #   Marshal.load(data)
    # end
  end
  private

  def build_tempfile
    require 'tempfile'
    file = Tempfile.new('saferuby')
    file.write(MAKE_SAFE_CODE)
    file.write <<-STRING
      begin
        result = eval('#{@code}')
        $stdout.puts Marshal.dump(result)
      rescue => e
        $stderr.puts e
      end
    STRING
    file.rewind
    file
  end
end

p SafeRuby.check('system("ls")', "[2,3,4]")
