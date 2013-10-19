class Chatter

  def initialize(io_loop)
    @clients = []
    @usernames = {}
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

    socket.on(:user) do |chunk|
      send("USER ##{@usernames[socket.id]} is now known as #{chunk[:username]}\n")
      @usernames[socket.id] = chunk[:username]
    end

    socket.on(:pvt) do |chunk|
      destination_id = @usernames.key(chunk[:username])
      dest = @clients.select{|socket| socket.id == destination_id}.first
      dest << "User ##{@usernames[socket.id]} sent a private message: #{chunk[:message]}\n"
    end

    socket.on(:list) do |chunk|
      socket << list_all_users
      socket << "\n"
    end

    socket.on(:bye) do |chunk|
      socket.emit(:close)
    end

    socket.on(:data) do |chunk|
      send("User ##{@usernames[socket.id]} said: #{chunk[:data]}")
    end

    socket.on(:close) do
      @clients.delete(socket)
      send("User ##{@usernames[socket.id]} left")
    end

    @clients << socket
    @usernames[socket.id] = id
  end

  def send(msg)
    @clients.each do |stream|
      stream << msg
    end
  end

  def list_all_users
    @usernames.values.join("\n")
  end

end
