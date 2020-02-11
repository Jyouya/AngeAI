-- This file initializes values when the AI is reloaded
State = 'LOAD'

AttackTarget = nil

-- Buff['Buff Name'] returns truthy if the buff is currently active
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

-- DefaultMob = {
--   priority = 1,
--   masterPriority = 10,
--   homunPriority = 4,
--   assistPriority = 5,
--   melee = true, -- will try to melee target, even while bolting
--   bolts = -1 -- no limit on vanil bolts per target
-- }

MobSettings = setmetatable(dofile('./AI/USER_AI/MobConfig.lua'),
                           {__index = function(t) return t.default end})

ActorBlacklist = {}

if not pcall(function() SkillDelay = dofile('./AI/USER_AI/skillDelay.lua') end) then
  SkillDelay = GetTick() - 1
end

World = setmetatable({}, {
  __index = function()
    error('Cannot access \'World\' before it is initialized')
  end
})

