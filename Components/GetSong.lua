local hasSong = 0
local restoreLeash
local restoreState

function GetSong(event, next)
  local options = T {}

  -- Are there any bards in range of master thought to be singing
  for id, bard in pairs(event.bards or {}) do
    if bard.singing > 0 and TaxiDistance(World.ownerId, id) < 15 then
      TraceAI(bard.singing)
      options:append(id)
    end
  end

  TraceAI(#options)

  -- Find the closest of those bards to the homun
  local target = options:reduce(function(a, b)
    return TaxiDistance(World.myId, a) < TaxiDistance(World.myId, b) and a or b
  end)

  if target then
    if TaxiDistance(World.myId, target) <= 3 then
      hasSong = World.tick
      Leash[restoreState] = restoreLeash
      restoreLeash = nil
    end
  end

  if target and hasSong + 18000 < World.tick then
    local targetX, targetY = GetV(V_POSITION, target)
    -- TODO: midpoint move if bard is too far
    Move(World.myId, targetX, targetY)
    if not restoreLeash then
      restoreLeash = Leash[State]
      restoreState = State
      Leash[State] = 13
    end
  else
    next()
  end
end
