local modules = {
  'AutoLoggout', 'SelectTarget', 'FollowOwner', 'MeleeChase', 'StuckCheck',
  'CheckLeash', 'MeleeAttack', 'ValidateTarget', 'MeleeDance', 'Command',
  'AutoHeel', 'GuardOwner', 'MoonlightSpam'
}

-- Don't change this line unless you know what you're doing
dofile('./AI/USER_AI/Components/index.lua')(unpack(modules))

Events:on('stateChange', InitializeStuckTimer)

Events:on('cycleStart', CullBlacklist)
Events:on('cycleStart', ProcessCommand)
Events:on('cycleStart', CheckLeash)
Events:on('cycleStart', AutoHeel)
Events:on('cycleStart', AutoLoggout)

Events:on('idle', ProcessCommandQueue)
Events:on('idle', SelectTarget)
Events:on('idle', GuardOwner)
-- Events:on('idle', GuardOwner2) -- Different guard movement, only enable one of these

Events:on('follow', FollowOwner)

Events:on('chase', ValidateTarget)
Events:on('chase', MeleeChase)
Events:on('chase', StuckCheck)

Events:on('attack', ValidateTarget)
Events:on('attack', MentalChangeOnAttack)
Events:on('attack', AttackingCheck)
Events:on('attack', MeleeAttack)
Events:on('attack', MoonlightSpam)
Events:on('attack', MeleeDance)

Events:on('moveCmd', MoveTo)
Events:on('moveCmd', StuckCheck2)

Events:on('stay', ProcessCommandQueue)

Events:on('heel', function(event, next)
  Events:unregister('idle', SelectTarget)
  next()
end)

Events:on('release', function(event, next)
  Events:on('idle', SelectTarget)
  next()
end)
