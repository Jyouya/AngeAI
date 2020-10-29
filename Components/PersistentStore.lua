local LTN = require('AI/USER_AI/LTN')
local changed = false

local store = {}

pcall(function()
  store = dofile('./AI/USER_AI/persistentStore.ltn') or {}
  TraceAI('successfully loaded store')
end)

function ReadPersistentStore(event, next)
  event.persistentStore = setmetatable({}, {
    __newindex = function(t, k, v)
      store[k] = v
      changed = true
    end,
    __index = store
  })
  next()
end

function WritePersistentStore(event, next)
  if changed then
    LTN.writeToFile(store, './AI/USER_AI/persistentStore.ltn')
  end
  next()
end

-- TODO: use metatables to track if the store was changed
-- only write if it was changed
