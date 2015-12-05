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

def send_message(socket)
  loop do
    sleep(1.5)
    if !$to_send.empty?
      message = $to_send.shift
      socket.puts message
    end
  end
end

# Connecting to the irc server
socket = TCPSocket.open(server, port)

# Login in and joining channel
socket.puts "NICK #{nick}\r\n"
socket.puts "USER #{nick} - - :#{nick}\r\n"
socket.puts "JOIN #{channel}\r\n"

# Create a thread that will send messages in $to_send array
$to_send = Array.new
reply_thread = Thread.new { send_message(socket) }

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
      module_reply = send(item, user_nick, nick, message, sent_to)
      if module_reply.kind_of?(Array)
        $to_send = $to_send + module_reply
      end
      
    end
  end

end
socket.close
