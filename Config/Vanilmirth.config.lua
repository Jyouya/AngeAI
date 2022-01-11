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

local kite = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1, -- lower priority for sleeping enemies since they're not a threat
  castingPriority = 1,
  melee = false, -- will try to melee target, even while bolting
  kite = true,
  bolts = -1 -- no limit on vanil bolts per target
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

local highPriority = {
  priority = 2,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1, 
  melee = true, 
  bolts = -1, 
  useOverspeed = false, 
  defenseLvl = 5, 
}

-- Edit this table to change default behavior
local default = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1, -- lower priority for sleeping enemies since they're not a threat
  castingPriority = 1, -- the hom will try to interrupt enemies that are casting
  melee = true, -- will try to melee target
  bolts = -1, -- no limit on vanil bolts per target
  useOverspeed = false, -- filir will use overspeed on all targets.  Good filirs do not need it on most targets, so consider setting to false if you have a high level bird
  defenseLvl = 5, -- Defense lvl for sheep to use
}
return {
  -- default = passive,
  [2519] = default, -- Pandaring
  [1582] = default, -- deviling
  [1120] = default,
  [2500] = kite, -- God Poring

  [1839] = ignore, -- Byorgue
  [1829] = kite, -- Sword Guardian
  [1830] = kite, -- Bow Guardian
}
