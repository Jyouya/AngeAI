-- local prevAttackTarget
-- local boltCounter
function HybridChase(event, next)
  if event.melee then
    MeleeChase(event, function()
      RangeAttackDuringChase(event, next)
    end)
  else
    RangeChase(event, next)
  end
end
