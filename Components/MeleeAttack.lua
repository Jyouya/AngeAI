function MeleeAttack(event, next)
  local dist = TaxiDistance(World.myId, AttackTarget)
  if dist <= 1 then
    Attack(World.myId, AttackTarget)
  else
    SetState('CHASE')
  end

  next()
end
