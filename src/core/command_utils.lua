local cooldowns = {}

local CommandUtils = {}

function CommandUtils.cooldown(user_id, command, seconds)
  seconds = seconds or 3
  local key = user_id .. ':' .. command
  local now = os.clock()
  local last = cooldowns[key]
  if last and (now - last) < seconds then
    local remaining = math.floor((seconds - (now - last)) * 10) / 10
    return remaining
  end
  cooldowns[key] = now
  return nil
end

return CommandUtils
