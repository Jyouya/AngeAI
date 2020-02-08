function MoonlightSpam(event, next)
  if World.mySP >= 20 then
    SkillObject(World.myId, 5, 8009, AttackTarget)
  end
  next()
end