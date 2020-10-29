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
  local lastFleetMove = event.persistentStore.lastFleetMove or 0

  -- Determine if fleet move is inactive, off cooldown, and we have sp
  if lastFleetMove + skillInfo.duration < World.tick and lastFleetMove +
    skillInfo.delay < World.tick and World.mySP > skillInfo.cost then
    if SkillDelay > World.tick then return end
    SkillObject(World.myId, fleetMoveLvl, 8010, World.myId)
    event.persistentStore.lastFleetMove = World.tick
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

