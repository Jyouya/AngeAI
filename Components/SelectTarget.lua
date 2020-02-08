function SelectTarget(event, next)
    TraceAI('Checking for targets')
    local dist = TaxiDistance(World.myId, World.ownerId)

    -- If we have exceeded our leash range, change state to follow
    if dist > Leash.IDLE then
        TraceAI("Distance from master is " .. dist)
        return SetState("FOLLOW")
    end

    local targetId = FindTarget()

    if targetId then
        BeginAttack(targetId)
        return
    end

    next()

end
