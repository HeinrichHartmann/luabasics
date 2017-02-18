--- Basic lua module functions
--
-- @module basicmod
--

local M = {}

local function gset(k, v)
  if _G[k] ~= nil then
    local msg = 'function ' .. k .. ' already exists in global scope.'
    print('NOTICE: ' .. msg .. ' Skipped.')
  else
    _G[k] = v
  end
end

--- wrap exported module
-- @param M module
--
-- Usage:
--
--   M = {...module definition ...}
--   return export(M)
--
-- Import:
--
-- * classical import (no pollution)
--
--   local <modname> = require "<modname>"
--
-- * export all functions
--
--   require("<modname>")()
--
-- * export parts
--
--   require "<modname>" { "printf" , "errorf" }
--
M.export = function(M)
  return setmetatable(
    M,
    {
      __call = function(M, imports)
        if imports then
          for _, k in ipairs(imports) do
            assert(M[k], "Function not found " .. k)
            gset(k, M[k])
          end
        else
          for k, v in pairs(M) do
            gset(k,v)
          end
        end
      end
    }
  )
end

return M.export(M)
