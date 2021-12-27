function CheckPVP(event, next) 
  for _, actorId in World.actors do
    local mobId = GetV(V_HOMUNTYPE, actorId)
    if mobId < 4048 then
      if IsMonster(actorId) then
        event.pvp = true
      end
    end
  end
  
  next() 
end
