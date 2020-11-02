local modules = {
  'AutoLoggout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'CheckLeash', 'MeleeAttack', 'ValidateTarget', 'MeleeDance', 'Command',
  'AutoHeel', 'GuardOwner', 'MoonlightSpam', 'TargetInfo',
  'FleetMove', 'OverSpeed', 'Protect'
}

Leash = {IDLE = 4, CHASE = 16, ATTACK = 16, FOLLOW = 4, GET_SONG = 13}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
-- ! Only enable one of the AutoHeel modules
-- Events:on('cycleStart', AutoHeel) -- Goes passive immediately on timeout
Events:on('cycleStart', AutoHeel2) -- Goes passive when current target dies on timeout
Events:on('cycleStart', AutoLoggout)

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)
Events:on('idle', GuardOwner)

Events:on('follow', FollowOwner)

Events:on('chase', TargetInfo)
Events:on('chase', ValidateTarget)
Events:on('chase', MeleeChase)
Events:on('chase', StuckCheck)
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
  Events:unregister('idle', GuardOwner)
  Events:on('idle', GuardOwner3)
  next()
end)

Events:on('release', function(event, next)
  Events:on('idle', SelectTarget)
  Events:unregister('idle' ,GuardOwner3)
  Events:on('idle', GuardOwner)
  next()
end)
