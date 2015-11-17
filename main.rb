#!/usr/bin/ruby

require 'socket'

# Server connection details
server = "chat.freenode.net"
port = "6667"
channel = "#a_channel_name"

# Bot details
nick = "simplerubybot"

# Loading every module in the module folder
def load_modules()
  # Require every module in module directory
  Dir["module/*.rb"].each {|file| require_relative file }

  # Loading module from directory in array
  $module_list = Dir["module/*.rb"]
  $module_list.map! {|item| item[/\/(.*?).rb/, 1]}
end
load_modules()

def get_nick(line)
   return line[/:(.*?)!/, 1]
end

def get_message(line)
   return line.partition(' :').last
end

def get_sent_to(line)
   return line[/PRIVMSG (.*?) :/, 1]
end

# Connecting to the irc server
socket = TCPSocket.open(server, port)

# Login in and joining channel
socket.puts "NICK #{nick}\r\n"
socket.puts "USER #{nick} - - :#{nick}\r\n"
socket.puts "JOIN #{channel}\r\n"


while line = socket.gets # Read from the socket forever
  puts line.chop      # Print everything read from the socket

  # Reply to ping
  if line.include? "PING"
    socket.puts "PONG :#{line.split(':').last}"
    puts "PONG :#{line.split(':').last}"
  end

  # Main loop
  $module_list.each do |item|
    if line.include? '!' + item

      # Getting info from message
      user_nick = get_nick(line)
      message = get_message(line)
      sent_to = get_sent_to(line)

      # Running the module
      socket.puts send(item, user_nick, nick, message, sent_to)
    end
  end

end
socket.close
