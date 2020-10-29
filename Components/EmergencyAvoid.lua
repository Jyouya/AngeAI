local emergencyAvoid = {
  [1] = {duration = 40000, delay = 5000, cost = 20},
  [2] = {duration = 35000, delay = 5000, cost = 25},
  [3] = {duration = 30000, delay = 5000, cost = 30},
  [4] = {duration = 25000, delay = 20000, cost = 35},
  [5] = {duration = 20000, delay = 25000, cost = 40}
}

local emergencyAvoidLvl = 5

local skill = emergencyAvoid[emergencyAvoidLvl]
function EmergencyAvoidOnChase(event, next)

  if SkillDelay < World.tick and Buffs['Mental Change'] and
    Buffs['Mental Change'] > World.tick + skill.delay and World.mySP >
    skill.cost and World.myHPP > .99 then
    SkillObject(World.myId, emergencyAvoidLvl, 8002, World.myId)
    SetSkillDelay(skill.delay)
    Buffs:add('Emergency Avoid', skill.duration)
    event.usedSkill = true
  end

  next()
end
