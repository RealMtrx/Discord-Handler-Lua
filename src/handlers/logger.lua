local Logger = {}

function Logger.startup_report(data)
  local mongo_status = data.mongo and '\x1b[32mConnected\x1b[0m' or '\x1b[31mDisconnected\x1b[0m'
  local ac_status = data.anticrash and '\x1b[32mActive\x1b[0m' or '\x1b[31mDisabled\x1b[0m'

  print('\n\x1b[36m' .. string.rep('=', 50) .. '\x1b[0m')
  print('\x1b[36m   ' .. data.name .. ' \x1b[36m— Startup Report\x1b[0m')
  print('\x1b[36m' .. string.rep('=', 50) .. '\x1b[0m')
  print('  \x1b[33mPrefix Commands:\x1b[0m    ' .. tostring(data.prefix))
  print('  \x1b[33mSlash Commands:\x1b[0m     ' .. tostring(data.slash))
  print('  \x1b[33mEvents Loaded:\x1b[0m      ' .. tostring(data.events))
  print('  \x1b[33mAntiCrash:\x1b[0m          ' .. ac_status)
  print('  \x1b[33mMongoDB:\x1b[0m            ' .. mongo_status)
  print('\x1b[36m' .. string.rep('=', 50) .. '\x1b[0m')
  print('\x1b[32m  Bot is fully operational!\x1b[0m\n')
end

return Logger
