local Emojis = require('core.emojis')
local CommandUtils = require('core.command_utils')

local PrefixPing = {}

PrefixPing.name = 'ping'

function PrefixPing.execute(message)
  local remaining = CommandUtils.cooldown(message.author.id, 'ping')
  if remaining then
    message:reply(Emojis.WARNING .. ' Please wait `' .. remaining .. 's` before using this command again.')
    return
  end

  local latency = math.floor((os.clock() - message.timestamp / 1000) * 1000)
  message:reply(Emojis.PING .. ' **Pong!** \u{1F3D3}\n\u{23F1}\u{FE0F} Latency: `' .. latency .. 'ms`')
end

return PrefixPing
