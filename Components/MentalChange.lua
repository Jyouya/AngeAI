local mentalChange = {
  [1] = {duration = 60000, delay = 25500, cost = 100},
  [2] = {duration = 180000, delay = 25500, cost = 100},
  [3] = {duration = 300000, delay = 25500, cost = 100}
}

local mentalChangeLvl = 3
local mentalChangeHealThreshold = .5

local skill = mentalChange[mentalChangeLvl]
function MentalChangeOnChase(event, next)

  if SkillDelay < World.tick and World.mySP > skill.cost then
    SkillObject(World.myId, mentalChangeLvl, 8004, World.myId)
    SetSkillDelay(skill.delay)
    Buffs:add('Mental Change', skill.duration)
    event.usedSkill = true
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
    event.usedSkill = true
  end

  next()
end

local newSession = true

function MentalChange(event, next)
  if World.mySPP < .1 then Store.mentalChangeEnd = 0 end
  local mentalChangeEnd = Store.mentalChangeEnd or 0
  if SkillDelay < World.tick and World.mySP >= skill.cost and
    (newSession or mentalChangeEnd < World.tick + 1000) then
    newSession = false
    SkillObject(World.myId, mentalChangeLvl, 8004, World.myId)
    SetSkillDelay(skill.delay)
    Store.mentalChangeEnd = World.tick + skill.duration
    event.usedSkill = true
  end

  next()
end

Events:on('cycleStart', function(event, next)
  if World.mySP < 200 then
    Store.mentalChangeEnd = 0
  end
  next()
end)

Events:on('reset', function(event, next)
  SetSkillDelay(1000)
  Store.mentalChangeEnd = 0
  next()
end)
