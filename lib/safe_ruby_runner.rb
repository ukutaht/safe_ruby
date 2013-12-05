class EvalError < StandardError
  def initialize(msg); super; end
end

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
    ChildProcess.build("ruby", temp.path).tap do |process|
      process.io.stdout = write
      process.io.stderr = write
      process.start
      process.wait
      write.close
    end

    data = read.read
    begin
      Marshal.load(data)
    rescue => e 
      raise EvalError.new(data)
    end
  end

  private

  def build_tempfile
    require 'tempfile'
    file = Tempfile.new('saferuby')
    file.write(MAKE_SAFE_CODE)
    file.write <<-STRING
      begin
        result = eval('#{@code}')
        print Marshal.dump(result)
      rescue => e
        print e.message
      end
    STRING
    file.rewind
    file
  end
end
