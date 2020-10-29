local LTN = require('AI/USER_AI/LTN')
local store = {}
pcall(function()
  store = dofile('./AI/USER_AI/persistentStore.ltn') or {}
  TraceAI('successfully loaded store')
end)

function ReadPersistentStore(event, next)
  event.persistentStore = store
  next()
end

function WritePersistentStore(event, next)
  store = event.persistentStore
  LTN.writeToFile(store, './AI/USER_AI/persistentStore.ltn')
  next()
end

-- TODO: use metatables to track if the store was changed
-- only write if it was changed
