#!/usr/bin/ruby

def module(nick, bot_nick, message, sent_to)

  formatted_module_list = ""
  $module_list.each do |item|
    formatted_module_list += "PRIVMSG #{sent_to} :#{item} \r\n"
  end

  return "PRIVMSG #{sent_to} :List of all loaded module:\r\n
          #{formatted_module_list}"
end
