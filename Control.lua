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
local onLoad
do
  local protoMobSettings
  onLoad = function(event)
    local myType = homunTypeNames[World.myType]

    local status, err = pcall(function()
      TraceAI('Hi, I\'m a ' .. myType)
      dofile('./AI/USER_AI/User Scripts/' .. myType .. '.lua')
    end)

    if not status then TraceAI('Failed to load user script file: ' .. err) end

    -- Load global config and homun type specific mob config
    -- Use prototypical delegation so it checks momSpecific -> global -> default for mob settings
    xpcall(function()
      local globalMobConfig = dofile('./AI/USER_AI/Config/MobConfig.lua')
      local typeSpecificMobConfig = dofile(
                                      './AI/USER_AI/Config/' .. myType ..
                                        '.config.lua')

      local protoMobSettings = setmetatable(globalMobConfig, {
        __index = function(t) return MobSettings.default end
      })

      MobSettings = setmetatable(typeSpecificMobConfig,
                                 {__index = protoMobSettings})

    end, function(err) TraceAI('Error loading config: ' .. err) end)

    Events:emit('load', event)

    SetState('IDLE')
    -- Events:emit('idle')
  end
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

    Events:emit('cycleEnd', event)
  end
end

