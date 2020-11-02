local bloodLust = {
  [1] = {duration = 60000, delay = 0, cost = 120},
  [2] = {duration = 180000, delay = 0, cost = 120},
  [3] = {duration = 300000, delay = 0, cost = 120}
}

local bloodLustLvl = 3

local skill = bloodLust[bloodLustLvl]

function BloodLustOnAttack(event, next)
  local lastBloodLust = Store.lastBloodLust or 0
  if lastBloodLust + skill.duration < World.tick and lastBloodLust + World.mySP >
    skill.cost and SkillDelay < World.tick or World.mySPP == 1 then
    SkillObject(World.myId, bloodLustLvl, 8008, World.myId)
    SetSkillDelay(400)
    Store.lastBloodLust = World.tick
  end

  next()
end
