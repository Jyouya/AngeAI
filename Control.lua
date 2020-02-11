do
  local prevState = 'LOAD'
  function SetState(newState)
    prevState = State
    StateChangeTime = World.tick
    State = newState

    TraceAI(
      'State changed from ' .. prevState .. ' to ' .. newState .. ' at ' ..
        World.tick)

    local status, res = xpcall(function()
      Events:emit('stateChange', {newState = newState, prevState = prevState})
    end, function() TraceAI(debug.traceback) end)

    if not status then
      TraceAI('Error in \'stateChange\' listeners at ' .. World.tick .. ': ' ..
                res)
    end
  end

  local stateStack = T {}
  function PushState(newState)
    stateStack:append(State)
    SetState(newState)
  end

  function PopState()
    if #stateStack > 0 then
      TraceAI(#stateStack)
      local res = stateStack:remove(#stateStack)
      SetState(res)
      return res
    end
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

local homunTypeNames = {

  [LIF] = 'Lif',
  [LIF2] = 'Lif',
  [LIF_H] = 'Lif',
  [LIF_H2] = 'Lif',
  [FILIR] = 'Filir',
  [FILIR2] = 'Filir',
  [FILIR_H] = 'Filir',
  [FILIR_H2] = 'Filir',
  [AMISTR] = 'Amistr',
  [AMISTR2] = 'Amistr',
  [AMISTR_H] = 'Amistr',
  [AMISTR_H2] = 'Amistr',
  [VANILMIRTH] = 'Vanilmirth',
  [VANILMIRTH2] = 'Vanilmirth',
  [VANILMIRTH_H] = 'Vanilmirth',
  [VANILMIRTH_H2] = 'Vanilmirth'
}

local function onLoad(event)
  local status, err = pcall(function()
    local myType = homunTypeNames[World.myType]
    TraceAI('Hi, I\'m a ' .. myType)
    dofile('./AI/USER_AI/User Scripts/' .. homunTypeNames[World.myType] ..
             '.lua')
  end)

  if not status then TraceAI('Failed to load user script file: ' .. err) end

  Events:emit('load', event)

  SetState('IDLE')
  -- Events:emit('idle')
end

local function onIdle(event) Events:emit('idle', event) end

local function onFollow(event) Events:emit('follow', event) end

local function onChase(event) Events:emit('chase', event) end

local function onAttack(event) Events:emit('attack', event) end

local function onMoveCmd(event) Events:emit('moveCmd', event) end

local function onStay(event) Events:emit('stay', event) end

local stateCallTable = {
  LOAD = onLoad,
  IDLE = onIdle,
  FOLLOW = onFollow,
  CHASE = onChase,
  ATTACK = onAttack,
  MOVE_CMD = onMoveCmd,
  STAY = onStay
}

-- Create a closure for worldLookup
do
  local worldLookup = {
    ownerId = function(world) return GetV(V_OWNER, world.myId) end,
    myPosition = function(world)
      local x, y = GetV(V_POSITION, world.myId)
      return {x = x, y = y}
    end,
    ownerPosition = function(world)
      local x, y = GetV(V_POSITION, world.ownerId)
      return {x = x, y = y}
    end,
    myType = function(world) return GetV(V_HOMUNTYPE, world.myId) end,
    myHP = function(world) return GetV(V_HP, world.myId) end,
    mySP = function(world) return GetV(V_SP, world.myId) end,
    myMaxHP = function(world) return GetV(V_MAXHP, world.myId) end,
    myMaxSP = function(world) return GetV(V_MAXSP, world.myId) end,
    myHPP = function(world) return world.myHP / world.myMaxHP end,
    mySPP = function(world) return world.mySP / world.myMaxSP end,
    ownerHP = function(world) return GetV(V_HP, world.ownerId) end,
    ownerSP = function(world) return GetV(V_SP, world.ownerId) end,
    ownerMaxHP = function(world) return GetV(V_MAXHP, world.ownerId) end,
    ownerMaxSP = function(world) return GetV(V_MAXSP, world.ownerId) end,
    ownerHPP = function(world) return world.ownerHP / world.ownerMaxHP end,
    ownerSPP = function(world) return world.ownerSP / world.ownerMaxSP end,
    msg = function(world) return GetMsg(world.myId) end,
    resMsg = function(world) return GetResMsg(world.myId) end,
    tick = GetTick,
    actors = GetActors
  }

  function AI(myId)

    World = setmetatable({myId = myId}, {
      __index = function(t, k)
        if not rawget(t, k) then t[k] = worldLookup[k](t) end
        return t[k]
      end
    })

    TraceAI('AI cycle start ' .. World.tick)
    local event = {}
    Events:emit('cycleStart', event)

    local fn = stateCallTable[State]

    if fn then
      fn(event)
    else
      Events:emit(State, event)
    end
  end
end

function FindTarget()
  local mobs = T {}
  -- local assistTarget = T {}

  for _, actorId in ipairs(World.actors) do
    -- Determine mob Priority
    -- Read priority from table or default
    -- Add priority if attacking master/homun
    local mobId = GetV(V_HOMUNTYPE, actorId)
    if CustomIsMonster(mobId) then
      local target = GetV(V_TARGET, actorId)
      local mob = MobSettings[mobId]
      local priority = mob.priority

      local blacklisted = ActorBlacklist[target]

      -- ? Should we allow the homun to protect additional targets other than master

      if target == World.ownerId then
        priority = priority +
                     (mob.masterPriority ~= nil and mob.masterPriority or
                       DefaultMob.masterPriority)
      elseif target == World.myId then
        priority = priority +
                     (mob.homunPriority ~= nil and mob.homunPriority or
                       DefaultMob.homunPriority)
      end

      TraceAI(string.format('Target: %i, Priority: %i', actorId, priority))

      -- TODO: check if master is attacking something, and add assist priority
      -- ! doesn't work.
      -- if actorId == World.ownerId then assistTarget:append({target, mobId}) end

      if priority > 0 and not blacklisted and actorId > 0 then
        mobs[#mobs + 1] = {mob.priority, actorId}
      end
    end
  end

  -- for _, v in ipairs(assistTarget) do
  --   local mob, i = mobs:with(2, v[1])
  --   mobs[i][1] = mob[1] + MobSettings[v[2]].assistPriority
  -- end

  if #mobs > 0 then
    local target = mobs:reduce(function(a, b)
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
