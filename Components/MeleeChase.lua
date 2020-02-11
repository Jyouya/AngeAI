function MeleeChase(event, next)
  local targetX, targetY = GetV(V_POSITION, AttackTarget)

  LongMove(targetX, targetY)
  local dist = TaxiDistance2(World.myPosition.x, World.myPosition.y, targetX,
                             targetY)
  if dist == 1 then SetState('ATTACK') end
  next()
end
