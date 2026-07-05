local config = {}

function config.load()
  local env = {}
  local file = io.open('.env', 'r')
  if file then
    for line in file:lines() do
      line = line:match('^%s*(.-)%s*$')
      if line ~= '' and not line:match('^#') then
        local key, val = line:match('^([^=]+)=(.*)$')
        if key then
          env[key:match('^%s*(.-)%s*$')] = val:match('^%s*(.-)%s*$')
        end
      end
    end
    file:close()
  end

  return {
    token = env.TOKEN or '',
    prefix = env.PREFIX or '!',
    bot_name = env.BOT_NAME or 'Discord Handler',
    owner_id = env.OWNER_ID or '',
    mongo_uri = env.MONGO_URI or 'mongodb://localhost:27017/discord-handler',
    error_webhook = env.ERROR_WEBHOOK or '',
    guild_log_webhook = env.GUILD_LOG_WEBHOOK or '',
  }
end

return config
