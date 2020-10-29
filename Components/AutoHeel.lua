local lastActive = GetTick()
local lastOwnerX, lastOwnerY = 0, 0
local autoHeel = false

-- Edit this value to set how long the alche must be idle for the hom to go passive
local autoHeelTimeout = 60000 -- In milliseconds

-- Will auto heel immediately upon timeout
function AutoHeel(event, next)

  if lastOwnerX == World.ownerPosition.x and lastOwnerY == World.ownerPosition.y then
    if World.tick > lastActive + autoHeelTimeout and not autoHeel then
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

-- Will auto heel on the next state change upon timeout 
local currentTarget
function AutoHeel2(event, next)
  if lastOwnerX == World.ownerPosition.x and lastOwnerY == World.ownerPosition.y and
    not autoHeel then
    if World.tick > lastActive + autoHeelTimeout then
      if currentTarget ~= AttackTarget then
        autoHeel = true
        Events:once('release', function(event, next)
          lastActive = GetTick()
          autoHeel = false
          next()
        end)
        Events:emit('heel')
      end
      currentTarget = AttackTarget
    end
  else
    lastOwnerX, lastOwnerY = World.ownerPosition.x, World.ownerPosition.y
    lastActive = World.tick
  end
  next()
end

