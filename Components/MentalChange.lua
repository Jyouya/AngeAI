local mentalChange = {
  [1] = {duration = 60000, delay = 3000},
  [2] = {duration = 180000, delay = 3000},
  [3] = {duration = 300000, delay = 3000}
}

local mentalChangeLvl = 3
local mentalChangeHealThreshold = .5

local skill = mentalChange[mentalChangeLvl]
function MentalChangeOnChase(event, next)

  if SkillDelay < World.tick and World.mySP > 100 then
    SkillObject(World.myId, mentalChangeLvl, 8004, World.myId)
    SetSkillDelay(skill.delay)
    Buffs:add('Mental Change', skill.duration)
  end

  next()
end

function MentalChangeOnAttack(event, next)
  -- TraceAI('Mental Change: ' .. Buffs['Mental Change'])
  if SkillDelay < World.tick and
    (World.myHPP < mentalChangeHealThreshold or not Buffs['Mental Change']) and
    World.mySP > 100 then
    SkillObject(World.myId, mentalChangeLvl, 8004, World.myId)
    SetSkillDelay(skill.delay)
    Buffs:add('Mental Change', skill.duration)
  end

  next()
end
