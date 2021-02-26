-- Mob presets
local passive = { -- Homun will not attack unless attacked
  priority = 0,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = 0,
  castingPriority = 0,
  melee = true,
  bolts = -1,
  useOverspeed = true,
  defenseLvl = 5
}

local ignore = { -- Homun will never attack unless you command it to
  priority = 0,
  masterPriority = 0,
  homunPriority = 0,
  assistPriority = 0,
  sleepingPriority = 0,
  castingPriority = 0,
  melee = true,
  bolts = -1,
  useOverspeed = false,
  defenseLvl = 0
}

local doNotBolt = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1,
  melee = true,
  bolts = 0,
  useOverspeed = true,
  defenseLvl = 5
}

local boltOnce = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1,
  melee = true,
  bolts = 1,
  useOverspeed = true,
  defenseLvl = 5
}

local boltTwice = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1,
  melee = true,
  bolts = 2,
  useOverspeed = false,
  defenseLvl = 5
}

local assistOnly = {
  priority = -1,
  masterPriority = 0,
  homunPriority = 0,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1,
  melee = true,
  bolts = -1,
  useOverspeed = true,
  defenseLvl = 5
}

return {
  -- Clocktower B4
  [1102] = boltOnce, -- Bathory
  [1179] = ignore, -- Whisper
  [1131] = ignore, -- Joker
}
