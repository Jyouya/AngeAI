local modules = {
  'AutoLoggout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'MentalChange', 'EmergencyAvoid', 'CheckLeash', 'MeleeAttack',
  'ValidateTarget', 'MeleeDance', 'Command', 'AutoHeel', 'GuardOwner',
  'TargetInfo', 'Protect'
}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
Events:on('cycleStart', AutoHeel2)
Events:on('cycleStart', AutoLoggout)

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)
Events:on('idle', EmergencyAvoidOnIdle)
Events:on('idle', GuardOwner)
-- Events:on('idle', GuardOwner2) -- Different guard movement, only enable one of these

Events:on('follow', FollowOwner)
Events:on('follow', EmergencyAvoid)

Events:on('chase', TargetInfo)
Events:on('chase', ValidateTarget)
Events:on('chase', MeleeChase)
Events:on('chase', StuckCheck)
Events:on('chase', MentalChange)
Events:on('chase', EmergencyAvoid)
Events:on('chase', ProtectOwner)

Events:on('attack', TargetInfo)
Events:on('attack', ValidateTarget)
Events:on('attack', MentalChange)
-- Events:on('attack', AttackingCheck)
Events:on('attack', MeleeAttack)
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
