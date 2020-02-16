local cos45 = math.sqrt(2) / 2
local sin45 = cos45
local cos30 = math.sqrt(3) / 2
local sin30 = 0.5

function Kite(event, next)
  if event.target.mobConfig.kite then

    -- Get vector of homun to target
    local vHomunX, vHomunY = World.myPosition.x - event.target.x,
                             World.myPosition.y - event.target.y

    -- convert offset vector to unit vector
    local uHomunX, uHomunY = UnitVector(vHomunX, vHomunY)

    -- 30 degree rotate and scale by 7
    local dHomunX, dHomunY = (uHomunX * cos30 - uHomunY * sin30) * 7,
                             (uHomunX * sin30 + uHomunX * cos30) * 7

    local x, y = math.round(event.target.x + dHomunX),
                 math.round(event.target.y + dHomunY)

    -- constrain target cell to be on screen
    x = math.max(World.ownerPosition.x - Leash[State],
                 math.min(x, World.ownerPosition.x + Leash[State]))
    y = math.max(World.ownerPosition.y - Leash[State],
                 math.min(y, World.ownerPosition.y + Leash[State]))

    Move(World.myId, x, y)
  else
    next()
  end
end
