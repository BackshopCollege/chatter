require 'socket'

class Client

  def initialize(host, port)
    @buffer = ""
    @running = false
    @socket = TCPSocket.new(host, port)
  end

  def start
    @running = true
    while @running
      r, w  = IO.select([@socket, $stdin], [@socket])

      r.each do |stream|
        read = stream.read_nonblock(4096)

        if stream.class == IO
          @buffer << read
        else
          puts read
        end

      end

      w.each do |stream|
        stream.write_nonblock(@buffer)
        @buffer = ""
      end
    end
  end

end

Client.new("0.0.0.0", "1234").start