# How to create a module

- Create a new file in the module folder named ``` command_name.rb ```

- Create a method inside the the file named ``` command_name ``` which receive 4 arguments; the nick of the one who sent the message, the nick of the bot, the message content, and the channel where the message was sent. (for and example check the help.rb module)

- The method must return a string that is an IRC command. ex: ``` "PRIVMSG #channel :hello" ``` you can send multiple command by separating the command in the string by separating the commands with ``` \r\n ```.
