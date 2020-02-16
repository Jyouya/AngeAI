function MeleeChase(event, next)

  LongMove(event.target.x, event.target.y)
  local dist = TaxiDistance2(World.myPosition.x, World.myPosition.y,
                             event.target.x, event.target.y)
  if dist == 1 then SetState('ATTACK') end
  next()
end
