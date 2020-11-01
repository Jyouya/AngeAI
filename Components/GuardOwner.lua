local relX, relY = 1, 0

-- Homun will move in epicycles around owner
function GuardOwner(event, next)

  Move(World.myId, World.ownerPosition.x + relX, World.ownerPosition.y + relY)

  -- Quick rotation matrix
  relX, relY = -relY, relX

  next()

end

local crossMove = {{0, 1}, {-1, 0}, {1, 0}, {0, -1}, i = 1}

-- Homun will move in a cross formation around the owner
function GuardOwner2(event, next)

  local coords = crossMove[crossMove.i + 1]
  crossMove.i = (crossMove.i + 1) % 4
  Move(World.myId, World.ownerPosition.x + coords[1],
       World.ownerPosition.y + coords[2])

  next()

end

-- Same as guard 1, but clockwise
function GuardOwner3(event, next) 

  Move(World.myId, World.ownerPosition.x + relX, World.ownerPosition.y + relY)

  relX, relY = relY, -relX

  next()

end
