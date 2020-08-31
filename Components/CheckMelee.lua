function CheckMelee(event, next)
  local mobId = GetV(V_HOMUNTYPE, AttackTarget)
  event.melee = MobSettings[mobId].melee
  next()
end
