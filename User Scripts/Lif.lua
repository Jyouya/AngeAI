local modules = {
  'AutoLogout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'MentalChange', 'EmergencyAvoid', 'CheckLeash', 'MeleeAttack',
  'ValidateTarget', 'MeleeDance', 'Command', 'AutoHeel', 'GuardOwner',
  'TargetInfo', 'Protect'
}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

-- Rotation matrices
local clockwise = {{0, 1}, {-1, 0}}
local counterclockwise = {{0, -1}, {1, 0}}

-- Guard presets
local guardClockwise = GuardOwner(clockwise, 0.8)
local guardCounterClockwise = GuardOwner(counterclockwise, 0.8)

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
-- first arg is how long the chem needs to be afk in seconds,
-- second arg is whether the hom should finish the current target first
Events:on('cycleStart', AutoHeel(60, true))
-- how many minutes the chem needs to afk before the client closes
Events:on('cycleStart', AutoLogout(70))

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)

Events:on('idle', guardCounterClockwise)

Events:on('follow', FollowOwner)
Events:on('follow', EmergencyAvoid(5))

Events:on('chase', TargetInfo)
Events:on('chase', ValidateTarget)
Events:on('chase', MeleeChase)
Events:on('chase', StuckCheck(1.5)) -- How many seconds the hom needs to be stuck to determine that target is unreachable
Events:on('chase', MentalChange)
Events:on('chase', EmergencyAvoid(5, function() return World.myHPP >= .25 end))
Events:on('chase', ProtectOwner)

Events:on('attack', TargetInfo)
Events:on('attack', ValidateTarget)
Events:on('attack', MentalChange)
Events:on('attack', EmergencyAvoid(5, function() return World.myHPP >= .25 end))
-- Events:on('attack', AttackingCheck)
Events:on('attack', MeleeAttack)
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
