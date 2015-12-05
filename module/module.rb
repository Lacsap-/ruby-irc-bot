#!/usr/bin/ruby

def module(nick, bot_nick, message, sent_to)

  formatted_module_list = ["PRIVMSG #{sent_to} :List of all loaded module:"]
  $module_list.each do |item|
    formatted_module_list.push("PRIVMSG #{sent_to} :#{item}")
  end

  return formatted_module_list
end
