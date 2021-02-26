local chaoticBenediction = {
  [1] = {cost = 40},
  [2] = {cost = 40},
  [3] = {cost = 40},
  [4] = {cost = 40},
  [5] = {cost = 40}
}

function ChaoticBenediction(level, masterHPP, homHPP)
  return function(event, next)
    if SkillDelay < World.tick and World.ownerHPP <= masterHPP and World.myHPP <=
      homHPP and World.mySP > 40 then
      SkillObject(World.myId, level, 8014, World.myId)
      SetSkillDelay(500)
    end

    next()
  end
end
