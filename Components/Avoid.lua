function Avoid(event, next)
  for _, actorId in ipairs(World.actors) do
    local mobId = GetV(V_HOMUNTYPE, actorId)
    local mob = MobSettings[mobId]

    if mob.avoidPriority then
      if GetDistanceSquared(actorId, World.myId) <
        (mob.avoidRadius or MobSettings.default.avoidRadius) ^ 2 then
        local targetId = FindTarget()
        if targetId and targetId ~= AttackTarget then
          BeginAttack(targetId)
        end
        break
      end
    end
  end
  next()
end
