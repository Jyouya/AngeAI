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
  priority = 5,
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

local healer = { -- for mobs that cast heal on the alche
  priority = 0,
  masterPriority = 0,
  homPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 0,
  melee = true,
  bolts = -1,
  useOverspeed = false,
  defenseLvl = 5
}

local snowHarpy = {
  priority = 2,
  masterPriority = 0,
  homPriority = 0,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 0,
  melee = true,
  bolts = -1,
  useOverspeed = true,
  defenseLvl = 5
}

local avoid = { -- Homun will try to avoid going near target
  priority = 0,
  masterPriority = 0,
  homunPriority = 0,
  assistPriority = 0,
  sleepingPriority = 0,
  castingPriority = 0,
  melee = true,
  bolts = -1,
  useOverspeed = false,
  defenseLvl = 0,
  avoidPriority = -10
}

local avoidGroups = { -- Homun will target this mob, but deprioritize large groups of this target
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1,
  castingPriority = 1,
  melee = true,
  bolts = -1,
  useOverspeed = true,
  defenseLvl = 5,
  avoidPriority = -1/4
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
  avoidRadius = 8,
  avoidPriority = 0, -- Added to mobs near the target.  Used to prevent targetting mobs near the target
}

return {
  default = default, -- ! DO NOT EDIT THIS LINE
  -- [1002] = doNotBolt, -- Poring
  -- [1004] = doNotBolt, -- Hornet
  -- [1005] = doNotBolt, -- Familiar
  -- [1007] = doNotBolt, -- Fabre
  -- [1008] = doNotBolt, -- Pupa
  -- [1009] = doNotBolt, -- Condor
  -- [1010] = doNotBolt, -- Willow
  -- [1011] = doNotBolt, -- Chonchon
  -- [1012] = doNotBolt, -- Roda Frog
  -- [1063] = doNotBolt, -- Lunatic
  -- [1113] = doNotBolt, -- Drops
  
  [1078] = doNotBolt, -- Red Plant
  [1079] = doNotBolt, -- Blue Plant
  [1080] = doNotBolt, -- Green Plant
  [1081] = ignore, -- Yellow Plant
  [1082] = ignore, -- White Plant
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
  [1031] = ignore, -- Poporing
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

  -- [mobID] = ignore, -- Mob Name

  -- Moscovia
  [1880] = passive, -- Wood Goblin
  [1881] = boltOnce, -- Les
  [1139] = passive, -- Mantis
  [1884] = highPriority, -- Mavka

  -- Neko Island
  [1586] = passive, -- Leaf cat
  [2502] = passive, -- Autumn Leaf cat
  [1261] = passive, -- Wild Rose
  [2590] = boltOnce, -- Nekoring

  -- Kiel Field
  [1368] = ignore, -- Geographer
  [1369] = boltTwice, -- Grand Peco

  -- Clocktower B4
  -- [1102] = boltOnce, -- Bathory
  [1179] = passive, -- Whisper
  [1131] = passive, -- Joker

  -- DG
  [1921] = highPriority, -- ghost

  -- Rachel Sanc
  [1769] = passive, -- Agav
  [1770] = highPriority, -- Echio

  -- Tina cave
  [1309] = highPriority, -- Gajomart
  [2154] = passive, -- Banaspaty

  -- Gonryun Dungeon
  [1408] = highPriority, -- Bloody Butterfly

  -- Lutia
  [3929] = healer, -- Ijsbal
  [3930] = snowHarpy, -- Snow Harpy -- not a healer, but want to ignore the lex cast

  -- Fairy Dungeon
  [1932] = ignore, -- Gardken Keeper
  [1933] = highPriority, -- Garden Watcher

}
