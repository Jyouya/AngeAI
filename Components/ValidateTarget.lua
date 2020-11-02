function ValidateTarget(event, next)
  if table.contains(World.actors, AttackTarget) then
      -- TraceAI('Target Motion is: ' .. tostring(GetV(V_MOTION, AttackTarget)))
      if GetV(V_MOTION, AttackTarget) == MOTION_DEAD then 
        TraceAI('target is dead')
        ActorBlacklist[AttackTarget] = World.tick
      else
        next()
      end
  else
    local targetId = FindTarget()

    if targetId and targetId > 0 then
      return BeginAttack(targetId)
    else
      return SetState('FOLLOW')
    end
  end
end
