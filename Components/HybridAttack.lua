function HybridAttack(event, next)
  if event.target.mobConfig.melee then
    MeleeAttack(event, function() RangedAttackDuringMelee(event, next) end)
  else
    RangeAttack(event, next)
  end
end
