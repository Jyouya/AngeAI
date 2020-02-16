local directions = {{'SW', 'S', 'SE'}, {'W', 'C', 'E'}, {'NW', 'N', 'NE'}}
local steps = {
  SW = {x = -1, y = -1},
  S = {x = 0, y = -1},
  SE = {x = 1, y = -1},
  W = {x = -1, y = 0},
  C = {x = 0, y = 1},
  E = {x = 1, y = 0},
  NW = {x = -1, y = 1},
  N = {x = 0, y = 1},
  NE = {x = 1, y = 1}
}
local startDirection

-- multiply by [[0, -1], [1, 0]]
-- linear algebra strikes again
local function Rotate90(vx, vy) return -1 * vy, vx end

function MeleeDance(event, next)
  local lon = World.myPosition.x < event.target.x and 1 or World.myPosition.x >
                event.target.x and 3 or 2
  local lat = World.myPosition.y < event.target.y and 1 or World.myPosition.y >
                event.target.y and 3 or 2

  local direction = directions[lat][lon]
  if not startDirection then startDirection = direction end

  local step = steps[direction]
  if direction == startDirection then
    local dx, dy = Rotate90(step.x, step.y)
    Move(World.myId, event.target.x + dx, event.target.y + dy)
  else
    Move(World.myId, event.target.x + step.x, event.target.y + step.y)
  end

  next()
end
