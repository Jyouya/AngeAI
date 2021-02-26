local kite = {
  priority = 1,
  masterPriority = 10,
  homunPriority = 4,
  assistPriority = 5,
  sleepingPriority = -1, -- lower priority for sleeping enemies since they're not a threat
  castingPriority = 1,
  melee = false, -- will try to melee target, even while bolting
  kite = true,
  bolts = -1 -- no limit on vanil bolts per target
}

return {}
