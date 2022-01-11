local modules = {
  'AutoLogout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'CheckLeash', 'MeleeAttack', 'ValidateTarget', 'MeleeDance', 'Command',
  'AutoHeel', 'GuardOwner', 'HybridAttack', 'RangeAttack', 'HybridDance',
  'HybridChase', 'RangeChase', 'RangeDance', 'TargetInfo', 'FindBards',
  'GetSong', 'CheckSong', 'Debug', 'Kite', 'Protect', 'ChaoticBenediction'
}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

-- Rotation matrices
local clockwise = {{0, 1}, {-1, 0}}
local counterclockwise = {{0, -1}, {1, 0}}

-- Guard presets
local guardClockwise = GuardOwner(clockwise, 0)
local guardCounterClockwise = GuardOwner(counterclockwise, 0)

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
-- first arg is how long the chem needs to be afk in seconds,
-- second arg is whether the hom should finish the current target first
Events:on('cycleStart', AutoHeel(60, true))
-- how many minutes the chem needs to afk before the client closes
Events:on('cycleStart', AutoLogout(70))
Events:on('cycleStart', FindBards)
Events:on('cycleStart', CheckSong)
Events:on('cycleStart', TraceActorInfo)

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)
Events:on('idle', CheckSong2)
Events:on('idle', guardCounterClockwise)
Events:on('idle', ChaoticBenediction(5, .7, .7)) -- heal if both hom and master are below 70%
Events:on('idle', ChaoticBenediction(3, 0.6, 1)) -- Always heal if master is below 60%
Events:on('idle', ChaoticBenediction(4, 1, 0.5)) -- always heal of hom is below 50%

Events:on('follow', FollowOwner)

Events:on('chase', TargetInfo)
Events:on('chase', ValidateTarget)
Events:on('chase', CheckSong2)
Events:on('chase', HybridChase)
Events:on('chase', StuckCheck(1.5)) -- How many seconds the hom needs to be stuck to determine that target is unreachable
Events:on('chase', ProtectOwner)

Events:on('attack', TargetInfo)
Events:on('attack', ValidateTarget)
-- Events:on('attack', AttackingCheck)
Events:on('attack', CheckSong2)
Events:on('attack', HybridAttack)
Events:on('attack', Kite)
Events:on('attack', HybridDance)
Events:on('attack', ProtectOwner)

Events:on('moveCmd', MoveTo)
Events:on('moveCmd', StuckCheck2)

Events:on('stay', ProcessCommandQueue)

Events:on('GET_SONG', GetSong)

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
