local defense = {
  [1] = {duration = 40000, delay = 0, cost = 20},
  [2] = {duration = 35000, delay = 0, cost = 25},
  [3] = {duration = 30000, delay = 0, cost = 30},
  [4] = {duration = 25000, delay = 0, cost = 35},
  [5] = {duration = 20000, delay = 0, cost = 40}
}

function DefenseOnAttack(event, next)
  local lastDefenseEnd = Store.lastDefenseEnd or 0
  local lvl = event.target.mobConfig.defenseLvl or
                MobSettings.defeault.defenseLvl or 0
  local skill = defense[lvl]

  if lvl > 0 and World.tick > lastDefenseEnd and World.mySP > skill.cost and
    SkillDelay < World.tick then
    SkillObject(World.myId, lvl, 8006, World.myId)
    SetSkillDelay(400)
    Store.lastDefenseEnd = World.tick + skill.duration
  end

  next()
end
