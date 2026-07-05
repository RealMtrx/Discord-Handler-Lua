local Emojis = require('core.emojis')

local SlashPing = {}

SlashPing.name = 'ping'
SlashPing.description = 'Replies with Pong!'

function SlashPing.execute(interaction)
  local latency = math.floor((os.clock() - interaction.id / 1000000) * 1000)
  interaction:reply({
    content = Emojis.PING .. ' **Pong!** \u{1F3D3}\n\u{23F1}\u{FE0F} Latency: `' .. latency .. 'ms`',
  })
end

return SlashPing
