-- Mob presets
local passive = { -- Homun will not attack unless attacked
  priority = 0,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  melee = true,
  bolts = -1
}

local ignore = { -- Homun will never attack unless you command it to
  priority = 0,
  masterPriority = 0,
  homunPriority = 0,
  assistPriority = 0,
  melee = true,
  bolts = -1
}

local doNotUseSkills = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  melee = true,
  bolts = 0
}

-- Edit this table to change default behavior
local default = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  melee = true, -- will try to melee target, even while 
  bolts = -1 -- no limit on caprice/moonlight per target
}

return {
  default = default, -- ! DO NOT EDIT THIS LINE

  [1589] = passive, -- Summon Plant Mandragora
  [1579] = passive, -- Summon Plant Hydra
  [1575] = passive, -- Summon Plant Flora
  [1555] = passive, -- Summon Plant Parasite
  [1590] = passive, -- Summon Plant Geographer

  [2191] = ignore, -- seaweed

  -- [1057] = ignore, -- yoyo
  -- [1002] = ignore, -- poring
  -- [1180] = ignore, -- ninetail
  -- [1031] = ignore, -- poporing
  -- [3880] = ignore
}
