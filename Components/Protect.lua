function ProtectOwner(event, next) 
    for _, actorId in ipairs(World.actors) do 
        if GetV(V_TARGET, actorId) == World.ownerId then
            TraceAI('Owner is under attack')
            local targetId = FindTarget()
            if targetId ~= AttackTarget then
                BeginAttack(targetId)
            end
            break
        end
    end
    next()
end