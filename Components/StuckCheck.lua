local stuckTimerChase
local stuckTimerAttack
local prevPosition
local chaseTimeout = 1200
local attackTimeout = 5000

function InitializeStuckTimer(event, next)
  stuckTimerChase = World.tick + 1500
  stuckTimerAttack = World.tick + 5000
  prevPosition = {x = 0, y = 0}
  next()
end

function StuckCheck(event, next)
  if prevPosition.x == World.myPosition.x and prevPosition.y ==
    World.myPosition.y then
    if stuckTimerChase < World.tick then
      TraceAI('I\'m Stuck chasing ' .. tostring(AttackTarget))
      ActorBlacklist[AttackTarget] = World.tick
      local targetId = FindTarget()

      if targetId then
        return BeginAttack(targetId)
      else
        return SetState('FOLLOW')
      end
    end

  else
    stuckTimerChase = World.tick + chaseTimeout
    prevPosition = {x = World.myPosition.x, y = World.myPosition.y}
  end
  next()
end

function StuckCheck2(event, next)
  if prevPosition.x == World.myPosition.x and prevPosition.y ==
    World.myPosition.y then
    if stuckTimerChase < World.tick then
      TraceAI('I\'m Stuck')
      return ProcessCommandQueue(event, function() end)
    end

  else
    stuckTimerChase = World.tick + chaseTimeout
    prevPosition = {x = World.myPosition.x, y = World.myPosition.y}
  end
  next()
end

function AttackingCheck(event, next)
  local myMotion = GetV(V_MOTION, World.myId)
  if myMotion ~= MOTION_ATTACK and not event.usedSkill then
    if stuckTimerChase < World.tick then
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
    stuckTimerAttack = World.tick + attackTimeout
  end

  next()
end

