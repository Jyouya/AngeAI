local bards = {}

function FindBards(event, next)
  local bardIds = table.filter(World.actors, function(actorId)
    local type = GetV(V_HOMUNTYPE, actorId)
    return type == BARD or type == CLOWN or type == BABY_BARD
  end)

  for _, bardId in pairs(bardIds) do
    local motion = GetV(V_MOTION, bardId)
    local bard = bards[bardId] or {singing = 0}
    if motion == MOTION_SING then
      -- Bard has started a song, record the time
      bard.singing = World.tick
    elseif motion > MOTION_MOVE or bard.singing + 180000 < World.tick then
      bard.singing = 0
    end
    bards[bardId] = bard
  end

  event.bards = bards

  next()
end
