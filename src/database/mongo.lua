local Mongo = { connected = false }

function Mongo.connect(uri)
  local ok, err = pcall(function()
    -- luamongo / lua-mongo not always available
    print('\x1b[33m[MongoDB] Stub: luamongo not installed, skipping connection\x1b[0m')
    Mongo.connected = false
  end)

  if ok and Mongo.connected then
    print('\x1b[32m[System] MongoDB connected\x1b[0m')
  else
    print('\x1b[33m[System] MongoDB not available (stub mode)\x1b[0m')
  end

  return Mongo.connected
end

function Mongo.is_connected()
  return Mongo.connected
end

function Mongo.get_client()
  return nil
end

return Mongo
