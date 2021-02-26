function AntiKS(event, next)
  for _, actorId in ipairs(World.actors) do
    if not CustomIsMonster(actorId) and actorId ~= World.myId and actorId ~=
      World.ownerId then
      local target = GetV(V_TARGET, actorId)
      if target then ActorBlacklist[target] = World.tick end
    end
  end
  next()
end
