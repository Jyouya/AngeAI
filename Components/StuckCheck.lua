local stuckTimer
local prevPosition

function InitializeStuckTimer(event, next)
  stuckTimer = World.tick + 1500
  prevPosition = {x = 0, y = 0}
  next()
end

function StuckCheck(event, next)
  if prevPosition.x == World.myPosition.x and prevPosition.y ==
    World.myPosition.y then
    if stuckTimer < World.tick then
      TraceAI('I\'m Stuck')
      ActorBlacklist[AttackTarget] = World.tick
      local targetId = FindTarget()

      if targetId then
        return BeginAttack(targetId)
      else
        return SetState('FOLLOW')
      end
    end

  else
    stuckTimer = World.tick + 1500
    prevPosition = {x = World.myPosition.x, y = World.myPosition.y}
  end
  next()
end

function StuckCheck2(event, next)
  if prevPosition.x == World.myPosition.x and prevPosition.y ==
    World.myPosition.y then
    if stuckTimer < World.tick then
      TraceAI('I\'m Stuck')
      return ProcessCommandQueue(event, function() end)
    end

  else
    stuckTimer = World.tick + 1500
    prevPosition = {x = World.myPosition.x, y = World.myPosition.y}
  end
  next()
end

function AttackingCheck(event, next)
  local myMotion = GetV(V_MOTION, World.myId)
  if myMotion ~= MOTION_ATTACK then
    if stuckTimer < World.tick then
      TraceAI('I can\'t hit my target')
      ActorBlacklist[AttackTarget] = World.tick
      local targetId = FindTarget()

      if targetId then
        return BeginAttack(targetId)
      else
        return SetState('FOLLOW')
      end
    end
  else
    stuckTimer = World.tick + 1500
  end

  next()
end

