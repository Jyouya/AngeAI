local hasSong = 0

-- function GetSong(event, next)
--   local options = T {}

--   -- Are there any bards in range of master thought to be singing
--   for id, bard in pairs(event.bards or {}) do
--     if bard.singing > 0 and TaxiDistance(World.ownerId, id) < 15 then
--       TraceAI(bard.singing)
--       options:append(id)
--     end
--   end

--   -- TraceAI(#options)

--   -- Find the closest of those bards to the homun
--   local target = options:reduce(function(a, b)
--     return TaxiDistance(World.myId, a) < TaxiDistance(World.myId, b) and a or b
--   end)

--   if target then
--     if TaxiDistance(World.myId, target) <= 3 then hasSong = World.tick end
--   end

--   if target and hasSong + 18000 < World.tick then
--     PushState('getSong')
--     local targetX, targetY = GetV(V_POSITION, target)
--     -- TODO: midpoint move if bard is too far
--     Move(World.myId, targetX, targetY)
--   else
--     next()
--   end
-- end

function CheckSong2(event, next)
  if event.closestBard and event.hasSong + 18000 < World.tick and State ~=
    'GET_SONG' then
    PushState('GET_SONG')
    return
  end
  next()
end

function GetSong(event, next)
  if event.closestBard and event.hasSong + 18000 < World.tick then
    local targetX, targetY = GetV(V_POSITION, event.closestBard)
    Move(World.myId, targetX, targetY)
    next()
  else
    PopState() -- go back to the state we were in before we tried to get bragi
  end

end

-- TODO: break this up
-- Part 1: find bards
-- Part 2: track if we have bragi
-- Part 3: if we don't have bragi, pushstate to move to bard
-- Part 4: Move to bard, if we get bragi or there are no bards, popstate
