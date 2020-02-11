-- 2723 through 2810 reserved for custom donation pets
function CustomIsMonster(mobId)
  return mobId > 1001 and mobId <= 3999 and (mobId < 2723 or mobId > 2810)
end

function GetDistanceSquared(id1, id2)
  local id1X, id1Y = GetV(V_POSITION, id1)
  local id2X, id2Y = GetV(V_POSITION, id2)
  return (id1X - id2X) ^ 2 + (id1Y - id2Y) ^ 2
end

function GetDistanceSquared2(x1, y1, x2, y2) return
  (x1 - x2) ^ 2 + (y1 - y2) ^ 2 end

function TaxiDistance(id1, id2)
  local id1X, id1Y = GetV(V_POSITION, id1)
  local id2X, id2Y = GetV(V_POSITION, id2)
  return math.max(math.abs(id1X - id2X), math.abs(id1Y - id2Y))
end

function TaxiDistance2(x1, y1, x2, y2)
  return math.max(math.abs(x1 - x2), math.abs(y1 - y2))
end

function LongMove(x, y)
  local euclidDist = GetDistanceSquared2(World.myPosition.x, World.myPosition.y,
                                         x, y)
  if euclidDist >= 121 then
    x = math.floor((x + World.myPosition.x) / 2)
    y = math.floor((y + World.myPosition.y) / 2)
  end
  Move(World.myId, x, y)
end

do
  local function doEvents(node, event)
    return function()
      if node then
        node.value(event, function()
          doEvents(node.next, event)()
          if node.next and node.next.once then
            node.next = node.next.next
          end
        end)
      end
    end
  end

  Events = setmetatable({}, {
    __index = {
      on = function(self, eventName, fn)
        local newNode = {value = fn}

        if not self[eventName] then
          self[eventName] = {value = function(event, next) next() end}
        end
        local node = self[eventName]
        -- traverse linked list and place node at the end
        while node.next do node = node.next end
        node.next = newNode
      end,
      once = function(self, eventName, fn)
        local newNode = {value = fn, once = true}

        if not self[eventName] then
          self[eventName] = {value = function(next) next() end}
        end
        local node = self[eventName]
        while node.next do node = node.next end
        node.next = newNode
      end,
      emit = function(self, eventName, event)
        local listeners = self[eventName]
        if listeners then
          TraceAI('Emitting ' .. eventName .. ' event.')
          event = event or {}
          doEvents(listeners, event)()
        end
      end,
      unregister = function(self, eventName, fn)
        if not self[eventName] then return end

        local node = self[eventName]
        while node.next and node.next.value ~= fn do node = node.next end
        if node.next and node.next.value == fn then
          node.next = node.next.next
        end

      end,
      clear = function(self, eventName) self[eventName] = nil end

    }
  })
end

function SetSkillDelay(delay)
  SkillDelay = World.tick + delay
  local file = io.open('./AI/USER_AI/skillDelay.lua', 'w')
  file:write('return ' .. SkillDelay)
  file:close()
end
