function HybridDance(event, next)
  if event.melee then
    MeleeDance(event, next)
  else
    RangeDance(event, next)
  end
end
