function RangeChase(event, next)
  local targetX, targetY = GetV(V_POSITION, AttackTarget)

  LongMove(targetX, targetY)
  local dist = GetDistanceSquared(World.myId, AttackTarget)
  if dist <= 81 then SetState('ATTACK') end
  next()
end
