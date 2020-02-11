local lastActive = GetTick()
local lastOwnerX, lastOwnerY = 0, 0
local autoHeel = false

function AutoHeel(event, next)

  if lastOwnerX == World.ownerPosition.x and lastOwnerY == World.ownerPosition.y then
    if World.tick > lastActive + 60000 and not autoHeel then
      autoHeel = true
      Events:once('release', function(event, next)
        lastActive = GetTick()
        autoHeel = false
        next()
      end)
      return Events:emit('heel')
    end
  else
    lastOwnerX, lastOwnerY = World.ownerPosition.x, World.ownerPosition.y
    lastActive = World.tick

  end
  next()
end

