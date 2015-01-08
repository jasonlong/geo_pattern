module SpecHelpers
  # Taken from active support
  #
  # Captures the given stream and returns it:
  #
  # stream = capture(:stdout) { puts 'notice' }
  # stream # => "notice\n"
  #
  # stream = capture(:stderr) { warn 'error' }
  # stream # => "error\n"
  #
  # even for subprocesses:
  #
  # stream = capture(:stdout) { system('echo notice') }
  # stream # => "notice\n"
  #
  # stream = capture(:stderr) { system('echo error 1>&2') }
  # stream # => "error\n"
  def capture(stream)
    stream = stream.to_s
    captured_stream = Tempfile.new(stream)
    stream_io = eval("$#{stream}")
    origin_stream = stream_io.dup
    stream_io.reopen(captured_stream)
    yield
    stream_io.rewind
    return captured_stream.read
  ensure
    captured_stream.close
    captured_stream.unlink
    stream_io.reopen(origin_stream)
  end
  alias :silence :capture
end

RSpec.configure do |config|
  config.include SpecHelpers
end
