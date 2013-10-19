#USER <username>
#LIST
#PVT <username> <message>
#BYE

class Protocol
  def self.parse(chunk)
    chunk   = chunk.strip.split(" ")
    command = chunk[0]

    case command
      when "USER"
        [:user, {username: chunk[1]}]
      when "LIST"
        [:list, {}]
      when "PVT"
        [:pvt, {username: chunk[1], message: chunk.slice(2, chunk.size).join(" ")}]
      when "BYE"
        [:bye, {}]
      else
        [:data, {data: chunk.join(" ")}]
    end
  end

end