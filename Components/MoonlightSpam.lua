local prevAttackTarget
local boltCounter
local moonlightLevel

function MoonlightSpam(event, next)
  if event.usedSkill then return next() end

  if AttackTarget ~= prevAttackTarget then
    -- local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = event.target.mobConfig.bolts or 0
    moonlightLevel = event.target.mobConfig.moonlightLevel or 5
  end
  if boltCounter ~= 0 and (SkillDelay < World.tick or boltCounter < 0) and
    World.mySP > 4 * moonlightLevel then
    if boltCounter > 0 then boltCounter = boltCounter - 1 end

    SkillObject(World.myId, moonlightLevel, 8009, AttackTarget)
    SetSkillDelay(400)
    event.usedSkill = true
  end

  next()
end

function Moonlight(fleetMove, overspeed)
  return function(event, next)
    local fleetMoveActive = (Store.fleetMoveEnd or 0) > World.tick
    local overspeedActive = (Store.overspeedEnd or 0) > World.tick

    if (not fleetMove or fleetMoveActive) and (not overspeed or overspeedActive) then
      MoonlightSpam(event, next)
    else
      next()
    end
  end
end
