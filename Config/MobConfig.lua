-- Attack priority is determined by taking the priority,
-- Then adding the homunPriority if the mob is attacking the homun
-- Then adding the assitPriority if the chemist is attacking the mob
-- And adding masterPriority if the mob is attacking the chemist
-- 

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
  useOverspeed = true, -- filir will use overspeed on all targets.  Good filirs do not need it on most targets, so consider setting to false if you have a high level bird
  defenseLvl = 5, -- Defense lvl for sheep to use
}

return {
  default = default, -- ! DO NOT EDIT THIS LINE
  [1002] = doNotBolt, -- Poring
  [1004] = doNotBolt, -- Hornet
  [1005] = doNotBolt, -- Familiar
  [1007] = doNotBolt, -- Fabre
  [1008] = doNotBolt, -- Pupa
  [1009] = doNotBolt, -- Condor
  [1010] = doNotBolt, -- Willow
  [1011] = doNotBolt, -- Chonchon
  [1012] = doNotBolt, -- Roda Frog
  [1063] = doNotBolt, -- Lunatic
  [1113] = doNotBolt, -- Drops
  
  [1078] = doNotBolt, -- Red Plant
  [1079] = doNotBolt, -- Blue Plant
  [1080] = doNotBolt, -- Green Plant
  [1081] = doNotBolt, -- Yellow Plant
  [1082] = doNotBolt, -- White Plant
  [1083] = doNotBolt, -- Shining Plant
  [1084] = doNotBolt, -- Black Mushroom
  [1085] = doNotBolt, -- Red Mushroom
  [1934] = doNotBolt, -- Blue Flower
  [1935] = doNotBolt, -- Red Flower
  [1936] = doNotBolt, -- Yellow Flower
  
  -- Pets
  -- It should properly detect pets now, so no need for these
  -- [1057] = ignore, -- Yoyo
  -- [1002] = ignore, -- Poring
  -- [1180] = ignore, -- Ninetail
  -- [1031] = ignore, -- Poporing
  -- [1776] = ignore, -- Siroma
  -- [2501] = ignore, -- Snow Bunny

  -- Summons
  [1142] = passive, -- Marine Sphere (Alchemist & Byalan)
  [1589] = passive, -- Summon Plant Mandragora
  [1579] = passive, -- Summon Plant Hydra
  [1575] = passive, -- Summon Plant Flora
  [1555] = passive, -- Summon Plant Parasite
  [1590] = passive, -- Summon Plant Geographer

  -- Unkillable Mobs
  [2191] = ignore, -- seaweed

  -- [mobID] = ignore -- Mob Name
}
