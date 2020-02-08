function FollowOwner(event, next)
  MoveToOwner(World.myId)
  local dist = TaxiDistance(World.myId, World.ownerId)
  if dist <= Leash.FOLLOW then
    TraceAI('Distance from master is ' .. dist)
    SetState('IDLE')
  end

  next()
end
