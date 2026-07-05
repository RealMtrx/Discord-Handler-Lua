local SlashPing = require('commands.slash.ping')
local Emojis = require('core.emojis')

local InteractionCreateEvent = {}

function InteractionCreateEvent.execute(interaction)
  if interaction.type ~= 2 then return end -- APPLICATION_COMMAND

  local cmd = interaction.data.name

  local ok, err = pcall(function()
    if cmd == SlashPing.name then
      SlashPing.execute(interaction)
    else
      interaction:reply({
        content = Emojis.ERROR .. ' Unknown command.',
        flags = 64, -- EPHEMERAL
      })
    end
  end)

  if not ok then
    print('\x1b[31m[InteractionCreate] Error in /' .. cmd .. ': ' .. tostring(err) .. '\x1b[0m')
    if not interaction.replied then
      interaction:reply({
        content = Emojis.ERROR .. ' Error executing command!',
        flags = 64,
      })
    end
  end
end

return InteractionCreateEvent
