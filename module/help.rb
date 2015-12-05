#!/usr/bin/ruby

def help(nick, bot_nick, message, sent_to)
  # If the bot received a PM it will reply only to the one
  # who sent the PM
  if bot_nick == sent_to
    sent_to = nick
  end

  help_message = ["PRIVMSG #{sent_to} :Enter the 'module' command to get a list of loaded module.",
                  "PRIVMSG #{sent_to} :To enter a command, just type '!' followed by the command name.",
                  "PRIVMSG #{sent_to} :ex: '!dummy_command'"]

  return help_message
end
