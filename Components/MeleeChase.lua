local counter = 0
function MeleeChase(event, next)
  LongMove(event.target.x, event.target.y)
  local dist = TaxiDistance2(World.myPosition.x, World.myPosition.y,
                             event.target.x, event.target.y)
  if dist <= 1 then SetState('ATTACK') end
  counter = counter + 1
  if dist == 2 and counter % 2 == 1 then
    local dx, dy = UnitVector(event.target.x - World.myPosition.x,
                              event.target.y - World.myPosition.y)
    LongMove(event.target.x + math.floor(dx + 0.5),
             event.target.y + math.floor(dy + 0.5))
  end

  next()
end
