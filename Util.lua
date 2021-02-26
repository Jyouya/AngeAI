-- 2723 through 2810 reserved for custom donation pets
function CustomIsMonster(actorId)
  -- return mobId > 1001 and mobId <= 3999 and (mobId < 2723 or mobId > 2810)
  return IsMonster(actorId) ~= 0 -- gravity fixed their shit it looks like
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

  local a2 = euclidDist -- distance from hom to taret squared
  local b2 = GetDistanceSquared(World.myId, World.ownerId) -- distance from hom to onwer squared
  local c2 = GetDistanceSquared2(World.ownerPosition.x, World.ownerPosition.y,
                                 x, y) -- distance from owner to target

  -- local b = math.sqrt(b2)
  -- local c = math.sqrt(c2)

  -- local cosA = (b2 + c2 - a2) / (2 * b * c)
  -- local A = math.acos(cosA) -- Angle of hom-owner-target

  -- if a2 >= 400 then

  --   if A > math.pi / 2 and b2 >= 25 then
  --     x, y = World.ownerPosition.x, World.ownerPosition.y
  --   else
  --     x = math.floor((x + World.myPosition.x) / 2)
  --     y = math.floor((y + World.myPosition.y) / 2)
  --   end

  -- end

  if a2 >= 250 and c2 < a2 and b2 > 4 then
    -- x, y = World.ownerPosition.x, World.ownerPosition.y
    return MoveToOwner(World.myId)
  end

  if euclidDist >= 500 then
    -- x = math.floor((x + World.myPosition.x) / 2)
    -- y = math.floor((y + World.myPosition.y) / 2)
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
        if not fn then
          error('Cannot register nil handler to event ' .. eventName)
        end
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
          self[eventName] = {value = function(event, next) next() end}
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
  Store.skillDelay = SkillDelay
  -- local file = io.open('./AI/USER_AI/skillDelay.lua', 'w')
  -- file:write('return ' .. SkillDelay)
  -- file:close()
end

do
  local mobIdLookup = {
    [45] = 'Portal',
    [844] = 'Invisible NPC',
    [111] = 'Invisible NPC'
  }
  local playerCiel = 110000000

  function ActorType(id)
    local mobType = GetV(V_HOMUNTYPE, id)
    if mobIdLookup[mobType] then return mobIdLookup[mobType] end
    if id < playerCiel then
      return 'Player'
    elseif mobType <= 16 then
      return 'Homunculus'
    elseif mobType < 1000 or mobType >= 4000 then
      return 'NPC'
    elseif IsMonster(id) ~= 0 then
      return 'Mob'
    else
      return 'Pet'
    end

    return 'Unknown'
  end
end

function BeginAttack(targetId)

  TraceAI('Targetting ' .. targetId)
  AttackTarget = targetId

  local dist = TaxiDistance(World.myId, targetId)

  -- Attack if in range, else chase
  if dist > 1 then
    return SetState('CHASE')
  else
    return SetState('ATTACK')
  end
end

function FindTarget()
  local mobs = T {}
  -- local assistTarget = T {}
  local masterTarget = GetV(V_TARGET, World.ownerId)
  TraceAI('Owner is attacking ' .. tostring(masterTarget))

  for _, actorId in ipairs(World.actors) do
    -- Determine mob Priority
    -- Read priority from table or default
    -- Add priority if attacking master/homun
    local mobId = GetV(V_HOMUNTYPE, actorId)
    if CustomIsMonster(actorId) then
      local target = GetV(V_TARGET, actorId)
      local mob = MobSettings[mobId]
      local priority = mob.priority

      local blacklisted = ActorBlacklist[actorId]
      -- TraceAI(tostring(actorId) .. ' is ' .. (blacklisted and 'blacklisted' or 'not blacklisted'))

      -- ? Should we allow the homun to protect additional targets other than master

      if target == World.ownerId then
        -- priority = priority +
        --              (mob.masterPriority ~= nil and mob.masterPriority or
        --                MobSettings.default.masterPriority)
        priority = priority +
                     (mob.masterPriority or MobSettings.default.masterPriority)
      elseif target == World.myId then
        priority = priority +
                     (mob.homunPriority or MobSettings.default.homunPriority)
      end

      local motion = GetV(V_MOTION, actorId)
      if motion == MOTION_CASTING then
        priority = priority +
                     (mob.castingPriority or MobSettings.default.castingPriority)
      elseif motion == MOTION_SLEEP then
        priority = priority +
                     (mob.sleepingPriority or
                       MobSettings.default.sleepingPriority)
      end

      if actorId == masterTarget then
        priority = priority +
                     (mob.assistPriority or MobSettings.default.assistPriority)
      end

      TraceAI(string.format('Target: %i, Priority: %i', actorId, priority))

      if priority > 0 and not blacklisted and actorId > 0 then
        mobs[#mobs + 1] = {priority, actorId}
      end
    end
  end

  -- for _, v in ipairs(assistTarget) do
  --   local mob, i = mobs:with(2, v[1])
  --   mobs[i][1] = mob[1] + MobSettings[v[2]].assistPriority
  -- end

  if #mobs > 0 then
    TraceAI('choosing between ' .. tostring(#mobs) .. ' targets')
    -- for i, v in ipairs(mobs) do
    --   TraceAI(tostring(i)..' '..tostring(v))
    -- end
    local target = mobs:ireduce(function(a, b)
      -- TraceAI('val1 '..tostring(a[1]) .. ' val2 '..tostring(b[1]))
      if a[1] == b[1] then -- targets are same priority, return the closest target
        return GetDistanceSquared(World.myId, a[2]) <
                 GetDistanceSquared(World.myId, b[2]) and a or b
      else
        return a[1] > b[1] and a or b
      end
    end)
    return target[2]
  end
end

-- Remove anything from the blacklist that was added more than 5 seconds ago
function CullBlacklist(event, next)

  local expired = World.tick - 5000
  for k, v in pairs(ActorBlacklist) do
    if v < expired then ActorBlacklist[k] = nil end
  end

  next()
end

function UnitVector(vx, vy)
  local m = math.sqrt(vx ^ 2 + vy ^ 2)
  return vx / m, vy / m
end
