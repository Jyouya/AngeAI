local emergencyAvoid = {
  [1] = {duration = 40000, delay = 5000, cost = 20},
  [2] = {duration = 35000, delay = 10000, cost = 25},
  [3] = {duration = 30000, delay = 15000, cost = 30},
  [4] = {duration = 25000, delay = 20000, cost = 35},
  [5] = {duration = 20000, delay = 25500, cost = 40}
}

-- local emergencyAvoidLvl = 5

-- local skill = emergencyAvoid[emergencyAvoidLvl]
-- function EmergencyAvoidOnIdle(event, next)
--   if not AttackTarget then
--     EmergencyAvoid(event, next)
--   else
--     next()
--   end
-- end

-- function EmergencyAvoid(event, next)
--   local mentalChangeEnd = Store.mentalChangeEnd or 0
--   if SkillDelay < World.tick and mentalChangeEnd > World.tick + skill.delay and
--     World.mySP >= skill.cost then

--     SkillObject(World.myId, emergencyAvoidLvl, 8002, World.myId)
--     SetSkillDelay(skill.delay)
--     event.usedSkill = true
--   end

--   next()
-- end

local heel
Events:on('heel', function(event, next)
  heel = true
  next()
end)
Events:on('release', function(event, next)
  heel = false
  next()
end)

function EmergencyAvoid(level, predicate)
  predicate = predicate or function() return true end
  local skill = emergencyAvoid[level]
  return function(event, next)
      local mentalChangeEnd = Store.mentalChangeEnd or 0
      if (heel or SkillDelay < World.tick and mentalChangeEnd > World.tick + skill.delay and
        World.mySP >= skill.cost) and predicate() then

        SkillObject(World.myId, level, 8002, World.myId)
        SetSkillDelay(skill.delay)
        event.usedSkill = true
      end
    next()
  end
end


