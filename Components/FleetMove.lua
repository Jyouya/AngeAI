local fleetMove = {
  [1] = {duration = 60000, delay = 75000, cost = 30},
  [2] = {duration = 55000, delay = 75000, cost = 40},
  [3] = {duration = 50000, delay = 75000, cost = 50},
  [4] = {duration = 45000, delay = 75000, cost = 60},
  [5] = {duration = 40000, delay = 75000, cost = 70}
}

local fleetMoveLvl = 5
local skillInfo = fleetMove[fleetMoveLvl]

function FleetMoveOnAttack(event, next)
  local lastFleetMove = Store.lastFleetMove or 0
  -- Determine if fleet move is inactive, off cooldown, and we have sp
  if lastFleetMove + skillInfo.duration < World.tick and lastFleetMove +
    skillInfo.delay < World.tick and World.mySP > skillInfo.cost then
    if SkillDelay > World.tick then return end
    SkillObject(World.myId, fleetMoveLvl, 8010, World.myId)
    Store.lastFleetMove = World.tick
    SetSkillDelay(400)
    event.usedSkill = true
  end

  next()
  -- Determine if fleet move is currently active
  -- if not, determine if fleet move is on cooldown
  -- if not, determine if we have sp
  -- if so, use fleet move
  -- record the time fleet move was used
end

function FleetMoveOnChase(event, next)
    local targetX, targetY = GetV(V_POSITION, AttackTarget)
    local euclidDist = GetDistanceSquared2(World.myPosition.x, World.myPosition.y,
                                         targetX, targetY)
  -- Don't want to do it during long moves, since the hom can start making those towards invalid targets                                       
  if euclidDist < 121 then
    FleetMoveOnAttack(event, function() 
        InitializeStuckTimer(event, next)
    end)
  end
end
