local modules = {
  'AutoLogout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'CheckLeash', 'MeleeAttack', 'ValidateTarget', 'MeleeDance', 'Command',
  'AutoHeel', 'GuardOwner', 'MoonlightSpam', 'TargetInfo', 'FleetMove',
  'OverSpeed', 'Protect'
}

Leash = {IDLE = 4, CHASE = 16, ATTACK = 16, FOLLOW = 4, GET_SONG = 13}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

-- Rotation matrices
local clockwise = {{0, 1}, {-1, 0}}
local counterclockwise = {{0, -1}, {1, 0}}

-- Guard presets.  Takes a transform and minimum HPP (so hom will stand still to recover hp if you want)
local guardClockwise = GuardOwner(clockwise, 0)
local guardCounterClockwise = GuardOwner(counterclockwise, 0)

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
-- first arg is how long the chem needs to be afk in seconds,
-- second arg is whether the hom should finish the current target first
Events:on('cycleStart', AutoHeel(180, true))
-- how many minutes the chem needs to afk before the client closes
Events:on('cycleStart', AutoLogout(70))

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)
Events:on('idle', guardCounterClockwise)

Events:on('follow', FollowOwner)

Events:on('chase', TargetInfo)
Events:on('chase', ValidateTarget)
Events:on('chase', MeleeChase)
-- How many seconds the hom needs to be stuck to determine that target is unreachable
Events:on('chase', StuckCheck(1.2))
Events:on('chase', FleetMoveOnChase)
Events:on('chase', OverspeedOnChase)
Events:on('chase', ProtectOwner)

Events:on('attack', TargetInfo)
Events:on('attack', ValidateTarget)
Events:on('attack', MeleeAttack)
Events:on('attack', FleetMoveOnAttack)
Events:on('attack', OverspeedOnAttack)
Events:on('attack', MoonlightSpam)
-- Events:on('attack', AttackingCheck)
Events:on('attack', MeleeDance)
Events:on('attack', ProtectOwner)

Events:on('moveCmd', MoveTo)
Events:on('moveCmd', StuckCheck2)

Events:on('stay', ProcessCommandQueue)

Events:on('heel', function(event, next)
  Events:unregister('idle', SelectTarget)
  Events:unregister('idle', guardCounterClockwise)
  Events:on('idle', guardClockwise)
  next()
end)

Events:on('release', function(event, next)
  Events:on('idle', SelectTarget)
  Events:unregister('idle', guardClockwise)
  Events:on('idle', guardCounterClockwise)
  next()
end)
