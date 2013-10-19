#USER <username>
#LIST
#PVT <username>
#BYE

class Protocol
  def self.parse(chunk)
    chunk   = chunk.strip.split(" ")
    command = chunk[0]

    if    command == "USER"
      [:user, {username: chunk[1]}]
    elsif command == "LIST"
      [:list, {}]
    elsif command == "PVT"
      [:pvt, {username: chunk[1], message: chunk.slice(2, chunk.size).join(" ")}]
    elsif command == "BYE"
      [:bye, {}]
    else
      [:data, {data: chunk}]
    end
  end

end