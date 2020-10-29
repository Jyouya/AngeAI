local prevAttackTarget
local boltCounter

function MoonlightSpam(event, next)
  if event.usedSkill then
    return next()
  end

  if AttackTarget ~= prevAttackTarget then
    -- local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = event.target.mobConfig.bolts or 0
  end
  if boltCounter ~= 0 and (SkillDelay < World.tick or boltCounter < 0) and
    World.mySP >= 20 then

    SkillObject(World.myId, 5, 8009, AttackTarget)
    SetSkillDelay(400)
    event.usedSkill = true
  end

  next()
end