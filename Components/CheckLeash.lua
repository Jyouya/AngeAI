function CheckLeash(event, next)
  local dist = TaxiDistance(World.myId, World.ownerId)

  if State ~= 'FOLLOW' and Leash[State] and dist > Leash[State] then
    TraceAI('Master is too far ' .. dist)
    SetState('FOLLOW')
  end

  next()

end
