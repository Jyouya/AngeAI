local overspeed = {
  [1] = {duration = 60000, delay = 60000, cost = 30},
  [2] = {duration = 55000, delay = 70000, cost = 40},
  [3] = {duration = 50000, delay = 80000, cost = 50},
  [4] = {duration = 45000, delay = 90000, cost = 60},
  [5] = {duration = 40000, delay = 120000, cost = 70}
}

local overspeedLvl = 5
local skillInfo = overspeed[overspeedLvl]

function OverspeedOnAttack(event, next)
  local lastOverspeed = Store.lastOverspeed or 0

  if event.target.mobConfig.useOverspeed and lastOverspeed + skillInfo.duration <
    World.tick and lastOverspeed + skillInfo.delay < World.tick and World.mySP >
    skillInfo.cost then
    if SkillDelay > World.tick then return end
    SkillObject(World.myId, overspeedLvl, 8011, World.myId)
    Store.lastOverspeed = World.tick
    SetSkillDelay(400)
    event.usedSkill = true
  end

  next()
end

function OverspeedOnChase(event, next)
    local targetX, targetY = GetV(V_POSITION, AttackTarget)
    local euclidDist = GetDistanceSquared2(World.myPosition.x, World.myPosition.y,
                                         targetX, targetY)
  -- Don't want to do it during long moves, since the hom can start making those towards invalid targets                                       
  if euclidDist < 121 then
    OverspeedOnAttack(event, next)
  end
end
