function RangeChase(event, next)

  LongMove(event.target.x, event.target.y)
  local dist = GetDistanceSquared(World.myId, AttackTarget)
  if dist <= 81 then SetState('ATTACK') end
  next()
end
