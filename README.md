# Discord Handler Lua

A modern, feature-rich Discord bot handler built with **Discordia**, featuring both slash commands and prefix commands with a robust modular architecture designed for scalability and maintainability.

## 🚀 Features

- **Dual Command System**: Support for both slash commands and prefix commands
- **Modular Architecture**: Clean separation of concerns with dedicated handlers
- **Anti-Crash System**: Comprehensive error handling and monitoring
- **Event-Driven**: Fully event-driven architecture
- **Webhook Logging**: Real-time logging for errors and guild events
- **MongoDB Integration**: Persistent data storage (requires luamongo)
- **Cooldown System**: Per-command cooldown management
- **Environment Configuration**: Secure configuration with custom .env parser

## 📁 Project Structure

```
Discord-Handler-Lua/
├── src/                          # Source code
│   ├── main.lua                  # Main bot entry point
│   ├── config/Config.lua         # Bot configuration from .env
│   ├── Core/                     # Core utilities
│   │   ├── CommandUtils.lua      # Cooldown and utilities
│   │   ├── Emojis.lua            # Centralized emoji definitions
│   │   └── WebhookUtil.lua       # Webhook utility
│   ├── Database/
│   │   └── Mongo.lua             # MongoDB connection (stub)
│   ├── Events/                   # Discord event handlers
│   │   ├── GuildCreate.lua       # Handler when bot joins a server
│   │   ├── GuildDelete.lua       # Handler when bot leaves a server
│   │   ├── InteractionCreate.lua # Handles slash command interactions
│   │   ├── MessageCreate.lua     # Handles prefix commands
│   │   └── Ready.lua             # Bot ready event
│   ├── Handlers/                 # Handlers for modularity
│   │   ├── AntiCrash.lua         # Crash prevention and error handling
│   │   └── Logger.lua            # Logger for bot activity
│   ├── Models/
│   │   └── UserModel.lua         # User data model
│   └── Commands/
│       ├── Prefix/               # Prefix commands
│       │   └── ping.lua          # Example prefix ping command
│       └── Slash/                # Slash commands
│           └── ping.lua          # Example slash ping command
```

## 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/RealMtrx/Discord-Handler-Lua.git
   cd Discord-Handler-Lua
   ```

2. **Install Lua dependencies**

   ```bash
   luarocks install discordia
   luarocks install luasec
   luarocks install luasocket
   luarocks install dkjson
   ```

3. **Environment Setup**

   Copy `.env.example` to `.env` and fill in your values:

   ```env
   TOKEN=your_bot_token_here
   PREFIX=!
   BOT_NAME=Discord Handler
   MONGO_URI=mongodb://localhost:27017/discord-handler
   ERROR_WEBHOOK=https://discord.com/api/webhooks/your_webhook
   GUILD_LOG_WEBHOOK=https://discord.com/api/webhooks/your_webhook
   ```

4. **Run the bot**

   ```bash
   lua src/main.lua
   ```

## 📋 Dependencies

- **Discordia**: - Discord API wrapper
- **luasec**: - TLS support
- **luasocket**: - Network support
- **dkjson**: - JSON parsing for webhooks

## 📝 Command Development

### Creating Slash Commands

Create a new file in `src/Commands/Slash/[name].lua`:

```lua
local SlashPing = {}

SlashPing.name = 'ping'
SlashPing.description = 'Replies with Pong!'

function SlashPing.execute(interaction)
  interaction:reply({ content = 'Pong! 🏓' })
end

return SlashPing
```

### Creating Prefix Commands

Create a new file in `src/Commands/Prefix/[name].lua`:

```lua
local PrefixPing = {}

PrefixPing.name = 'ping'

function PrefixPing.execute(message)
  message:reply('Pong! 🏓')
end

return PrefixPing
```

---

**Discord Handler** — Built by **Mtrx** — Discord: **0hu2**
