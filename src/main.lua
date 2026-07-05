-- Add src/ to package.path for clean requires
local src = arg and arg[0]:match('^(.+)/[^/]+$') or '.'
package.path = package.path .. ';' .. src .. '/?.lua;' .. src .. '/*/?.lua;' .. src .. '/*/*/?.lua'

local discordia = require('discordia')
local config_module = require('config.config')
local ReadyEvent = require('events.ready')
local GuildCreateEvent = require('events.guild_create')
local GuildDeleteEvent = require('events.guild_delete')
local InteractionCreateEvent = require('events.interaction_create')
local MessageCreateEvent = require('events.message_create')
local AntiCrash = require('handlers.anti_crash')
local Logger = require('handlers.logger')
local Mongo = require('database.mongo')

print('\x1b[36m\u{2554}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2557}\x1b[0m')
print('\x1b[36m\u{2551}     Starting Discord Handler     \u{2551}\x1b[0m')
print('\x1b[36m\u{255A}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{2550}\u{255D}\x1b[0m')
print()

local config = config_module.load()
local client = discordia.Client()

print('\x1b[34m[System] Initializing AntiCrash...\x1b[0m')
AntiCrash.init({ webhook_url = config.error_webhook })

print('\x1b[34m[System] Connecting to MongoDB...\x1b[0m')
local mongo_connected = Mongo.connect(config.mongo_uri)

client:on('ready', function()
  ReadyEvent.execute(client, config)

  Logger.startup_report({
    name = config.bot_name,
    prefix = 1,
    slash = 1,
    events = 5,
    anticrash = true,
    mongo = mongo_connected,
  })
end)

client:on('guildCreate', function(guild)
  GuildCreateEvent.execute(guild, config)
end)

client:on('guildDelete', function(guild)
  GuildDeleteEvent.execute(guild, config)
end)

client:on('interactionCreate', function(interaction)
  InteractionCreateEvent.execute(interaction)
end)

client:on('messageCreate', function(message)
  MessageCreateEvent.execute(message, config)
end)

client:run('Bot ' .. config.token)
