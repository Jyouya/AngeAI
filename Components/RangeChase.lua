function RangeChase(event, next)
  local targetX, targetY = GetV(V_POSITION, AttackTarget)
  local euclidDist = GetDistanceSquared(World.myId, AttackTarget)
  if euclidDist >= 100 then
    targetX = math.floor((targetX + World.myPosition.x) / 2)
    targetY = math.floor((targetY + World.myPosition.y) / 2)
  end

  Move(World.myId, targetX, targetY)
  local dist = GetDistanceSquared(World.myId, AttackTarget)
  if dist <= 81 then SetState('ATTACK') end
  next()
end
