function MeleeChase(event, next)
  local targetX, targetY = GetV(V_POSITION, AttackTarget)
  local euclidDist = GetDistanceSquared(World.myId, AttackTarget)
  if euclidDist >= 100 then
    targetX = math.floor((targetX + World.myPosition.x) / 2)
    targetY = math.floor((targetY + World.myPosition.y) / 2)
  end

  Move(World.myId, targetX, targetY)
  local dist = TaxiDistance2(World.myPosition.x, World.myPosition.y, targetX,
                             targetY)
  if dist == 1 then SetState('ATTACK') end

  -- TODO: if target is too far, move to halfway point between homun and target
  next()
end
