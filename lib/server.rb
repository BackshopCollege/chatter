class Server < Stream

  def handle_read
    sock = @io.accept_nonblock
    emit(:accept, Stream.new(sock))
    rescue IO::WaitReadable
  end

  def handle_write
  end

end