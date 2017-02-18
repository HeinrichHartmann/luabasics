local json = require "cjson"
local serpent = require "serpent"

--------------------------------------------------------------------------------
-- Calling

function exec(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
end

function execf(...)
  return exec(string.format(...))
end

--------------------------------------------------------------------------------
-- Persistence

function storestr(name, str)
  local fh = io.open(name, "w")
  fh:write(std)
  fh:close()
end

function loadstr(name)
  local fh = io.open(name, "r")
  if not fh then return end
  local out = fh:read("*a")
  fh:close()
  return out
end

function storej(name, o)
  strestr(json.encode(o))
end

function loadj(name)
  return json.decode(loadstr(name))
end

--------------------------------------------------------------------------------
-- Logging

function log(s)
  io.stderr:write(s .. "\n")
end

function logf(...)
  log(string.format(...))
end

function logs(...)
  log(serpent.line(...))
end

function logj(...)
  log(json.encode(...))
end

--------------------------------------------------------------------------------
-- Printing

function printf(...)
  io.stdout:write(string.format(...))
end

function prints(...)
  io.stdout:write(serpent.block(...))
end

function printj(...)
  io.stdout:write(json.encode(...))
end
