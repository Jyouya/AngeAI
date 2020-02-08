require('AI/USER_AI/windowerLibs/queues')

local commandQueue = Q {}

do
  local cmdX, cmdY = 0, 0
  function HandleMoveCommand(x, y)
    if x == World.ownerPosition.x and y == World.ownerPosition.y then
      SetState('IDLE')
    else
      cmdX, cmdY = x, y
      SetState('MOVE_CMD')
    end
  end

  function MoveTo(event, next)

    if World.myPosition.x ~= cmdX or World.myPosition.y ~= cmdY then
      Move(World.myId, cmdX, cmdY)

      -- Pass the command coordinates in case anything down the line wants them
      event.cmdX, event.cmdY = cmdX, cmdY
      next()
    else
      SetState('STAY')
      ProcessCommandQueue(event, function() end)
    end
  end

end

function HandleSkillObjectCommand(lvl, skill, targetId)
  SkillObject(World.myId, lvl, skill, targetId)
end

function HandleSkillAreaCommand(lvl, skill, x, y)
  SkillGround(World.myId, lvl, skill, x, y)
end

do
  local heel = false
  Events:on('heel', function(event, next)
    heel = true
    next()
  end)
  function HandleFollowCommand()
    if heel then
      Events:emit('release')
      heel = false
    else
      Events:emit('heel')
    end
  end
end

local commands = {
  [MOVE_CMD] = HandleMoveCommand,
  [FOLLOW_CMD] = HandleFollowCommand,
  [SKILL_OBJECT_CMD] = HandleSkillObjectCommand,
  [SKILL_AREA_CMD] = HandleSkillAreaCommand
}

local function doCommand(msg)
  local cmd = msg[1]
  table.remove(msg, 1)

  -- TraceAI('MSG: ' .. cmd)
  if commands[cmd] then commands[cmd](unpack(msg)) end
end

function ProcessCommand(event, next)
  doCommand(World.msg)

  if not World.msg[1] then
    if World.resMsg[1] ~= NONE_CMD then commandQueue:push(World.resMsg) end
  else
    commandQueue:clear()
  end

  next()
end

function ProcessCommandQueue(event, next)
  if not commandQueue:empty() then
    local msg = commandQueue:pop()
    doCommand(msg)
  end

  next()
end

