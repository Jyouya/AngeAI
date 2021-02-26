-- This file initializes values when the AI is reloaded
State = 'LOAD'
AttackTarget = nil
ActorBlacklist = {}

-- Buffs['Buff Name'] returns truthy if the buff is currently active
do
  local buffTable = {}

  Buffs = setmetatable({
    add = function(self, buff, duration) self[buff] = duration end,
    remove = function(self, buff) self[buff] = false end
  }, {
    __index = function(t, k)
      return buffTable[k] and buffTable[k] > World.tick and buffTable[k]
    end,
    __newindex = function(t, k, v)
      if v then
        buffTable[k] = World.tick + v
      else
        buffTable[k] = 0
      end
    end
  })

end

-- if not pcall(function() SkillDelay = dofile('./AI/USER_AI/skillDelay.lua') end) then
--   SkillDelay = GetTick() - 1
-- end
SkillDelay = Store.skillDelay or GetTick() - 1

World = setmetatable({}, {
  __index = function()
    error('Cannot access \'World\' before it is initialized')
  end
})

