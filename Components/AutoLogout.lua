local lastActive = GetTick()
local lastOwnerX, lastOwnerY = 0, 0

function AutoLogout(minutes)
  local timeout = minutes * 60000
  return function(event, next)
    if lastOwnerX == World.ownerPosition.x and lastOwnerY ==
      World.ownerPosition.y then
      if World.tick > lastActive + timeout then return os.exit() end
    else
      lastOwnerX, lastOwnerY = World.ownerPosition.x, World.ownerPosition.y
      lastActive = World.tick

    end
    next()
  end
end
