function TraceActorInfo(event, next)
  local res = ' Actor Info: \n'
  for _, id in ipairs(World.actors) do
    -- if id ~= World.myId and id ~= World.ownerId then
    local mobId = GetV(V_HOMUNTYPE, id)
    local mobHP = GetV(V_HP, id)
    local mobType = ActorType(id)
    -- local x, y = GetV(13, id, 8013, 5)
    -- -- local a, b = GetV(14, id, 8013, 5)
    -- local isMonster = IsMonster(id)
    res = res ..
            string.format('actorId: %i, mobId: %i, mobHP: %i, mobType: %s\n',
                          id, mobId, mobHP, mobType)
  end
  -- end

  if #World.actors then TraceAI(res) end
  next()
end

function LogMsg(event, next)
  TraceAI(string.format(' Msg: %i, ResMsg: %i', World.msg, World.resMsg))
  next()
end
