function TargetInfo(event, next)
  local mobId = GetV(V_HOMUNTYPE, AttackTarget)
  event.target = {}
  event.target.mobId = mobId
  event.target.mobConfig = MobSettings[mobId]
  event.target.x, event.target.y = GetV(V_POSITION, AttackTarget)

  next()
end
