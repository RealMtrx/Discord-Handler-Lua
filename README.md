# Discord Handler Lua

A modern, feature-rich Discord bot handler built with Lua and Discordia, featuring both slash commands and prefix commands with a robust modular architecture.

## Features

- Slash commands and prefix commands
- MongoDB integration (stub via luamongo)
- Modular architecture (commands, events, handlers)
- Anti-crash system with error reporting
- Cooldown system
- Unicode emoji exports
- Webhook logging

## Prerequisites

- Lua 5.3+ or LuaJIT
- Luarocks

## Dependencies

```bash
luarocks install discordia
luarocks install luasec
luarocks install luasocket
luarocks install dkjson
```

## Setup

1. Clone the repository
2. Copy `.env.example` to `.env` and fill in your bot token and other configuration
3. Run the bot:
```bash
lua src/main.lua
```

## Project Structure

```
src/
├── main.lua                    # Entry point
├── config/config.lua           # Configuration loader
├── commands/slash/ping.lua     # Slash ping command
├── commands/prefix/ping.lua    # Prefix ping command
├── core/emojis.lua             # Unicode emoji exports
├── core/command_utils.lua      # Cooldown utilities
├── core/webhook_util.lua       # Webhook utility
├── database/mongo.lua          # MongoDB connection (stub)
├── events/ready.lua            # Ready event
├── events/guild_create.lua     # Guild join event
├── events/guild_delete.lua     # Guild leave event
├── events/interaction_create.lua # Slash command handler
├── events/message_create.lua   # Prefix command handler
├── handlers/anti_crash.lua     # Error handling
├── handlers/logger.lua         # Startup logger
└── models/user_model.lua       # User data model
```

## License

MIT License - see [LICENSE](LICENSE) for details.
