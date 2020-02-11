local hasSong = 0

function CheckSong(event, next)
  local options = T {}

  -- Are there any bards in range of master thought to be singing
  for id, bard in pairs(event.bards or {}) do
    if bard.singing > 0 and TaxiDistance(World.ownerId, id) < 15 then
      TraceAI(bard.singing)
      options:append(id)
    end
  end

  local target = options:reduce(function(a, b)
    return TaxiDistance(World.myId, a) < TaxiDistance(World.myId, b) and a or b
  end)

  if target then
    if TaxiDistance(World.myId, target) <= 3 then hasSong = World.tick end
  end

  event.hasSong = hasSong
  event.closestBard = target

  next()
end
