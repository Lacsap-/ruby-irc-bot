#!/usr/bin/ruby

require 'open-uri'

def lainchan_list(nick, bot_nick, message, sent_to)

  # If the bot received a PM it will reply only to the one
  # who sent the PM
  if bot_nick == sent_to
    sent_to = nick
  end

  command_split = message.split
  board = command_split[1]
  number_of_thread = (Integer(command_split[2]) rescue false)
  puts number_of_thread.is_a?(Integer)

  board_list = ["tech", "cyb", "lam", "layer", "zzz", "drg",
  "lit", "diy", "art", "w", "rpg", "r", "q"]

  reply = Array.new
  if board_list.any? { |w| board[w] } && number_of_thread.is_a?(Integer)

    # Getting threads subject from catalog
    source = URI.parse("https://lainchan.org/#{board}/catalog.html").read
    titles = source.scan(/<span class="subject">(.*?)<\/span>/)

    if titles.count < number_of_thread
      number_of_thread = titles.count
    end

    for i in 0..number_of_thread-1
      reply.push("PRIVMSG #{sent_to} :#{titles[i]}")
    end

  end
  return reply
end
