-- ! Maybe move this to the CheckSong file
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
    LongMove(targetX, targetY)
    next()
  else
    PopState() -- go back to the state we were in before we tried to get bragi
  end

end

-- // TODO: break this up
-- Part 1: find bards
-- Part 2: track if we have bragi
-- Part 3: if we don't have bragi, pushstate to move to bard
-- Part 4: Move to bard, if we get bragi or there are no bards, popstate
