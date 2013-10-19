class IOWatcher
  attr_accessor :streams

  def initialize
    @streams = []
  end

  def << (_streams)
    @streams << _streams
    _streams.on(:close) do
      @streams.delete _streams
    end
  end

  def listen(host, port)
    server = Server.new(TCPServer.new(host, port))
    self << server
    server.on(:accept) do |stream|
      self << stream
    end
    server
  end

  def start
    @running = true
    tick while @running
  end

  def stop
    @running = false
  end

  def tick
    r, w = IO.select(@streams, @streams)

    r.each do | stream |
      stream.handle_read
    end

    w.each do |stream|
      stream.handle_write
    end

  end
end