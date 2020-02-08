function ValidateTarget(event, next)
  if table.contains(World.actors, AttackTarget) then
    next()
  else
    local targetId = FindTarget()

    if targetId and targetId > 0 then
      return BeginAttack(targetId)
    else
      return SetState('FOLLOW')
    end
  end
end
