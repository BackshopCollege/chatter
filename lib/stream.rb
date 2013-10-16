class Stream
  include Emitter

  def initialize(io)
    @io = io
    @buffer = ''
  end

  def to_io; @io ; end
  
  def << (chunk)
    @buffer << chunk
  end

  def handle_read
    chunk = @io.read_nonblock(4096)
    emit(:data, chunk)
    rescue IO::WaitReadable
    rescue EOFError, Errno::ECONNRESET
      emit(:close)
  end

  def handle_write
    return if @buffer.empty?
    length = @io.write_nonblock(@buffer)
    @buffer.slice!(0,length)
    rescue IO::WaitWritable
    rescue EOFError, Errno::ECONNRESET
      emit(:close)
  end
end