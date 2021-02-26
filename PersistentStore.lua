local LTN = require('AI/USER_AI/LTN')
local changed = false

local _store = {}
Store = {}

pcall(function()
  _store = dofile('./AI/USER_AI/persistentStore.ltn') or {}
  TraceAI('successfully loaded store')
end)

function ReadPersistentStore()
  Store = setmetatable({}, {
    __newindex = function(t, k, v)
      _store[k] = v
      changed = true
    end,
    __index = _store
  })
end

ReadPersistentStore() -- Initialize Store

function WritePersistentStore()
  if changed then
    changed = false
    LTN.writeToFile(_store, './AI/USER_AI/persistentStore.ltn')
  end
end
