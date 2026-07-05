local https = require('ssl.https')
local ltn12 = require('ltn12')
local json = require('dkjson')

local ReadyEvent = {}

function ReadyEvent.execute(client, config)
  client:setStatus(true, 'online', 0, 'Playing with ' .. config.bot_name)
  print('\x1b[32m[Ready] Logged in as ' .. client.user.username .. '#' .. client.user.discriminator .. '\x1b[0m')

  -- Register slash commands via REST API
  local payload = json.encode({
    name = 'ping',
    description = 'Replies with Pong!',
  })

  local app_id = client.application.id
  local url = 'https://discord.com/api/v10/applications/' .. app_id .. '/commands'

  local response_body = {}
  https.request({
    url = url,
    method = 'POST',
    headers = {
      ['Content-Type'] = 'application/json',
      ['Authorization'] = 'Bot ' .. config.token,
      ['Content-Length'] = #payload,
    },
    source = ltn12.source.string(payload),
    sink = ltn12.sink.table(response_body),
  })

  print('\x1b[32m[Commands] Slash command \'ping\' registered\x1b[0m')
end

return ReadyEvent
