<div align="center">
  <h1>Discord Handler — Lua</h1>
  <p><strong>A production-ready Discord bot framework built with Discordia and MongoDB — slash commands, prefix commands, anti-crash, webhook logging, and a modular src/ architecture.</strong></p>

  <p>
    <a href="https://github.com/RealMtrx/Discord-Handler-Lua/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Lua/releases"><img src="https://img.shields.io/badge/version-0.9.0--beta-yellow" alt="Version 0.9.0 Beta"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Lua/stargazers"><img src="https://img.shields.io/github/stars/RealMtrx/Discord-Handler-Lua" alt="Stars"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Lua/issues"><img src="https://img.shields.io/github/issues/RealMtrx/Discord-Handler-Lua" alt="Issues"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler-Lua/network"><img src="https://img.shields.io/github/forks/RealMtrx/Discord-Handler-Lua" alt="Forks"></a>
    <a href="https://github.com/RealMtrx/Discord-Handler/graphs/contributors"><img src="https://img.shields.io/badge/ecosystem-26%20repos-brightgreen" alt="26 Repos"></a>
    <a href="https://discord.gg/0hu2"><img src="https://img.shields.io/badge/discord-0hu2-5865F2" alt="Discord"></a>
  </p>

  <br>

  <p>
    <a href="#-features">Features</a> •
    <a href="#-quick-start">Quick Start</a> •
    <a href="#-project-structure">Structure</a> •
    <a href="#-api-reference">API</a> •
    <a href="#-database-edition">SQL Edition</a> •
    <a href="#-related-repositories">Ecosystem</a>
  </p>
</div>

---

## Overview

Discord Handler Lua is the **Lua edition** of the multi-language Discord Handler ecosystem. Built on the `Discordia` library, it provides a modular, event-driven foundation for Discord bots with dual command support (slash + prefix), MongoDB persistence, webhook-based logging, and an anti-crash layer.

The entry point (`src/main.lua`) boots in a predictable sequence: configure the package path for clean requires, initialize the anti-crash handler, connect to MongoDB, register event listeners (ready, guild create/delete, interaction create, message create), and finally present a startup report before the client goes online.

## Features

- **Dual Command System** — Slash commands via interactionCreate and prefix commands via messageCreate
- **Modular Architecture** — Separated concerns across `config/`, `core/`, `database/`, `events/`, `handlers/`, `models/`, and `commands/`
- **Anti-Crash** — Global error interception via `xpcall` that reports failures to a Discord webhook
- **Webhook Logging** — Separate webhooks for error alerts and guild join/leave events
- **MongoDB Integration** — Persistent storage via `luamongo` (stub connection in `database/mongo.lua`)
- **Cooldown System** — Per-command cooldown tracked in `core/command_utils.lua`
- **Environment Configuration** — All secrets managed through a custom `.env` parser in `config/config.lua`

## Quick Start

```bash
git clone https://github.com/RealMtrx/Discord-Handler-Lua.git
cd Discord-Handler-Lua
```

Install Lua dependencies:

```bash
luarocks install discordia
luarocks install luasec
luarocks install luasocket
luarocks install dkjson
```

Copy `.env.example` to `.env` and fill in your values:

```env
TOKEN=your_bot_token_here
PREFIX=!
BOT_NAME=Discord Handler
MONGO_URI=mongodb://localhost:27017/discord-handler
ERROR_WEBHOOK=https://discord.com/api/webhooks/your_webhook
GUILD_LOG_WEBHOOK=https://discord.com/api/webhooks/your_webhook
```

```bash
lua src/main.lua
```

### Dependencies

| Library | Purpose |
|---------|---------|
| `discordia` | Discord API wrapper |
| `luasec` | TLS support |
| `luasocket` | Network support |
| `dkjson` | JSON parsing for webhooks |

## Project Structure

```
Discord-Handler-Lua/
├── .env.example
├── src/
│   ├── main.lua                      # Entry point — boot sequence
│   ├── config/config.lua             # Custom .env parser and config table
│   ├── core/
│   │   ├── command_utils.lua         # Cooldown helper
│   │   ├── emojis.lua                # Centralized emoji constants
│   │   └── webhook_util.lua          # Webhook dispatch utility
│   ├── database/mongo.lua            # MongoDB connection stub
│   ├── events/
│   │   ├── guild_create.lua          # Guild join → webhook
│   │   ├── guild_delete.lua          # Guild leave → webhook
│   │   ├── interaction_create.lua    # Slash command dispatcher
│   │   ├── message_create.lua        # Prefix command dispatcher
│   │   └── ready.lua                 # Ready event + startup report
│   ├── handlers/
│   │   ├── anti_crash.lua            # Global error interception via xpcall
│   │   └── logger.lua                # Startup report formatter
│   ├── models/user_model.lua         # User data schema
│   └── commands/
│       ├── prefix/ping.lua           # Example prefix command
│       └── slash/ping.lua            # Example slash command
```

## API Reference

### Entry Point — `src/main.lua`

Extends `package.path` for clean requires, creates a `discordia.Client()`, wires five event handlers, and calls `client:run()`.

### Configuration — `src/config/config.lua`

Returns a table with keys matching `.env`:

```lua
config.token          -- Bot token
config.prefix         -- Command prefix (default: "!")
config.bot_name       -- Display name
config.mongo_uri      -- MongoDB connection string
config.error_webhook  -- Error reporting URL
config.guild_log_webhook -- Guild event logging URL
```

### Events

| Event | File | Trigger |
|-------|------|---------|
| `ready` | `events/ready.lua` | Bot goes online — logs startup |
| `guildCreate` | `events/guild_create.lua` | Bot joins a server — sends join webhook |
| `guildDelete` | `events/guild_delete.lua` | Bot leaves a server — sends leave webhook |
| `interactionCreate` | `events/interaction_create.lua` | Slash command used — routes to command module |
| `messageCreate` | `events/message_create.lua` | Message sent — checks prefix, routes to prefix command |

### Core Utilities

- **CommandUtils** — `CommandUtils.check_cooldown(command, user_id)` checks cooldown expiry
- **WebhookUtil** — `WebhookUtil.send(webhook_url, content)` fires an embed to a Discord webhook
- **Emojis** — Centralized emoji constant map for consistent bot responses

## Adding Commands

### Slash Command

Create `src/commands/slash/your_command.lua`:

```lua
local SlashCommand = {}

SlashCommand.name = 'yourcommand'
SlashCommand.description = 'Does something useful'

function SlashCommand.execute(interaction)
  interaction:reply({ content = 'Done!' })
end

return SlashCommand
```

### Prefix Command

Create `src/commands/prefix/your_command.lua`:

```lua
local PrefixCommand = {}

PrefixCommand.name = 'yourcommand'

function PrefixCommand.execute(message)
  message:reply('Done!')
end

return PrefixCommand
```

The `message_create` event automatically requires and dispatches modules in `commands/prefix/` when the message starts with `PREFIX`.

## Database Edition

A **Sequelize (SQL)** variant of this handler is available for teams that prefer a relational database over MongoDB:

[RealMtrx/Discord-Handler-Lua-Sequelize](https://github.com/RealMtrx/Discord-Handler-Lua-Sequelize)

It replaces `database/mongo.lua` with a Sequelize-based connection and supports SQLite, PostgreSQL, MySQL, MariaDB, and MSSQL out of the box. All other modules — events, commands, handlers, core utilities — remain identical.

## Related Repositories

The Discord Handler ecosystem spans **26 repositories** across 13 languages, each available in both MongoDB and Sequelize editions.

### Base Repositories (MongoDB)

| Language | Repository |
|----------|------------|
| C++ | [RealMtrx/Discord-Handler-Cpp](https://github.com/RealMtrx/Discord-Handler-Cpp) |
| C# | [RealMtrx/Discord-Handler-Cs](https://github.com/RealMtrx/Discord-Handler-Cs) |
| Dart | [RealMtrx/Discord-Handler-Dart](https://github.com/RealMtrx/Discord-Handler-Dart) |
| Go | [RealMtrx/Discord-Handler-Go](https://github.com/RealMtrx/Discord-Handler-Go) |
| Java | [RealMtrx/Discord-Handler-Java](https://github.com/RealMtrx/Discord-Handler-Java) |
| JavaScript | [RealMtrx/Discord-Handler-Js](https://github.com/RealMtrx/Discord-Handler-Js) |
| Kotlin | [RealMtrx/Discord-Handler-Kt](https://github.com/RealMtrx/Discord-Handler-Kt) |
| Lua | [RealMtrx/Discord-Handler-Lua](https://github.com/RealMtrx/Discord-Handler-Lua) |
| PHP | [RealMtrx/Discord-Handler-Php](https://github.com/RealMtrx/Discord-Handler-Php) |
| Python | [RealMtrx/Discord-Handler-Py](https://github.com/RealMtrx/Discord-Handler-Py) |
| Ruby | [RealMtrx/Discord-Handler-Rb](https://github.com/RealMtrx/Discord-Handler-Rb) |
| Rust | [RealMtrx/Discord-Handler-Rs](https://github.com/RealMtrx/Discord-Handler-Rs) |
| TypeScript | [RealMtrx/Discord-Handler](https://github.com/RealMtrx/Discord-Handler) ← hub |

### Sequelize (SQL) Editions

| Language | Repository |
|----------|------------|
| C++ | [RealMtrx/Discord-Handler-Cpp-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cpp-Sequelize) |
| C# | [RealMtrx/Discord-Handler-Cs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Cs-Sequelize) |
| Dart | [RealMtrx/Discord-Handler-Dart-Sequelize](https://github.com/RealMtrx/Discord-Handler-Dart-Sequelize) |
| Go | [RealMtrx/Discord-Handler-Go-Sequelize](https://github.com/RealMtrx/Discord-Handler-Go-Sequelize) |
| Java | [RealMtrx/Discord-Handler-Java-Sequelize](https://github.com/RealMtrx/Discord-Handler-Java-Sequelize) |
| JavaScript | [RealMtrx/Discord-Handler-Js-Sequelize](https://github.com/RealMtrx/Discord-Handler-Js-Sequelize) |
| Kotlin | [RealMtrx/Discord-Handler-Kt-Sequelize](https://github.com/RealMtrx/Discord-Handler-Kt-Sequelize) |
| Lua | [RealMtrx/Discord-Handler-Lua-Sequelize](https://github.com/RealMtrx/Discord-Handler-Lua-Sequelize) |
| PHP | [RealMtrx/Discord-Handler-Php-Sequelize](https://github.com/RealMtrx/Discord-Handler-Php-Sequelize) |
| Python | [RealMtrx/Discord-Handler-Py-Sequelize](https://github.com/RealMtrx/Discord-Handler-Py-Sequelize) |
| Ruby | [RealMtrx/Discord-Handler-Rb-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rb-Sequelize) |
| Rust | [RealMtrx/Discord-Handler-Rs-Sequelize](https://github.com/RealMtrx/Discord-Handler-Rs-Sequelize) |
| TypeScript | [RealMtrx/Discord-Handler-Ts-Sequelize](https://github.com/RealMtrx/Discord-Handler-Ts-Sequelize) |

> **[RealMtrx/Discord-Handler](https://github.com/RealMtrx/Discord-Handler)** — the TypeScript hub and flagship repository. Star it to support the ecosystem.

## License

Distributed under the MIT License. See `LICENSE` for more information.

---

Built by **Mtrx** — Discord: **0hu2**
