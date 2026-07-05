local PrefixPing = require('commands.prefix.ping')
local Emojis = require('core.emojis')

local MessageCreateEvent = {}

function MessageCreateEvent.execute(message, config)
  if message.author.bot then return end

  local content = message.content
  if not content:find('^' .. config.prefix) then return end

  local args = {}
  for word in content:sub(#config.prefix + 1):gmatch('%S+') do
    table.insert(args, word)
  end
  local cmd_name = args[1] and args[1]:lower() or ''
  table.remove(args, 1)

  if cmd_name == PrefixPing.name then
    PrefixPing.execute(message)
  else
    message:reply(Emojis.ERROR .. ' Unknown command. Use `' .. config.prefix .. 'help` for a list of commands.')
  end
end

return MessageCreateEvent
