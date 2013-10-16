class Chatter
  
  def initialize(io_loop)
    @clients = []
    @client_id = 0
    @loop = io_loop
  end

  def next_id
    @client_id += 1
  end

  def start
    self << @loop.listen('0.0.0.0', 1234)
    @loop.start
  end

  def << (client)
    client.on(:accept) do |socket|
      add_socket(socket)
    end
  end

  def add_socket(socket)
    id = next_id
    send("User ##{id} joined\n")

    socket.on(:data) do |chunk|
      send("User ##{id} said: #{chunk}")
    end

    socket.on(:close) do
      @clients.delete(socket)
      send("User ##{id} left")
    end

    @clients << socket
  end

  def send(msg)
    @clients.each do |stream|
      stream << msg
    end
  end

end
