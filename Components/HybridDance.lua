function HybridDance(event, next)
  if event.target.mobConfig.melee then
    MeleeDance(event, next)
  else
    RangeDance(event, next)
  end
end
