local WebhookUtil = require('core.webhook_util')

local AntiCrash = { webhook_url = nil }

function AntiCrash.init(opts)
  opts = opts or {}
  AntiCrash.webhook_url = opts.webhook_url

  xpcall(function()
    -- Wrap main execution
  end, function(err)
    AntiCrash.report_error('Unhandled Error', tostring(err) .. '\n' .. debug.traceback())
  end)

  print('\x1b[32m[AntiCrash] Active\x1b[0m')
end

function AntiCrash.report_error(title, message)
  print('\x1b[31m[AntiCrash] ' .. title .. ': ' .. message .. '\x1b[0m')
  if AntiCrash.webhook_url and AntiCrash.webhook_url ~= '' then
    WebhookUtil.send_webhook(AntiCrash.webhook_url, '**' .. title .. '**\n```\n' .. message .. '\n```')
  end
end

return AntiCrash
