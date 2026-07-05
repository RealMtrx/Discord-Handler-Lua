local WebhookUtil = require('core.webhook_util')

local GuildCreateEvent = {}

function GuildCreateEvent.execute(guild, config)
  print('\x1b[32m[GuildCreate] Joined: ' .. guild.name .. ' (' .. guild.id .. ')\x1b[0m')
  WebhookUtil.send_webhook(config.guild_log_webhook,
    '**Joined Server**\nName: ' .. guild.name .. '\nID: ' .. guild.id ..
    '\nMembers: ' .. tostring(guild.memberCount))
end

return GuildCreateEvent
