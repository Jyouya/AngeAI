local dx, dy = 1, 0

function RangeDance(event, next)
  -- can we hit the target while dancing around master?
  -- if so, do that
  -- otherwise dance on the edge of our range
  local targetOwnerDist = GetDistanceSquared(World.ownerId, AttackTarget)
  if targetOwnerDist <= 64 then
      return GuardOwner(event, next)
  end

  Move(World.myId, World.myPosition.x + dx, World.myPosition.y + dy)

  -- No escape from the rotation matrix
  dx, dy = -dy, dx

  next()

end