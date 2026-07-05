local WebhookUtil = require('core.webhook_util')

local GuildDeleteEvent = {}

function GuildDeleteEvent.execute(guild, config)
  print('\x1b[31m[GuildDelete] Left: ' .. guild.name .. ' (' .. guild.id .. ')\x1b[0m')
  WebhookUtil.send_webhook(config.guild_log_webhook,
    '**Left Server**\nName: ' .. guild.name .. '\nID: ' .. guild.id)
end

return GuildDeleteEvent
