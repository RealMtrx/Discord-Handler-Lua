local https = require('ssl.https')
local ltn12 = require('ltn12')
local json = require('dkjson')

local WebhookUtil = {}

function WebhookUtil.send_webhook(url, content, opts)
  if not url or url == '' then return end
  opts = opts or {}

  local payload = json.encode({
    content = content,
    username = opts.username,
    avatar_url = opts.avatar_url,
  })

  local response_body = {}
  local res, code = https.request({
    url = url,
    method = 'POST',
    headers = {
      ['Content-Type'] = 'application/json',
      ['Content-Length'] = #payload,
    },
    source = ltn12.source.string(payload),
    sink = ltn12.sink.table(response_body),
  })

  if code ~= 204 then
    print('\x1b[31m[Webhook] Failed with code ' .. tostring(code) .. '\x1b[0m')
  end
end

return WebhookUtil
