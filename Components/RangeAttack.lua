local caprice = {
  [1] = {delay = 2000},
  [2] = {delay = 2200},
  [3] = {delay = 2400},
  [4] = {delay = 2600},
  [5] = {delay = 2800}
}
local capriceLvl = 5

local prevAttackTarget
local boltCounter

function RangeAttack(event, next)
  if AttackTarget ~= prevAttackTarget then
    -- local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = event.target.mobConfig.bolts or 0
  end
  if boltCounter ~= 0 and (SkillDelay < World.tick or boltCounter < 0) and
    World.mySP >= (20 + 2 * capriceLvl) then
    SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
    SetSkillDelay(caprice[capriceLvl].delay)
    event.usedSkill = true
  end

  next()
end

function RangeAttackDuringChase(event, next)
  local dist = GetDistanceSquared(World.myId, AttackTarget)

  if dist <= 81 then
    if AttackTarget ~= prevAttackTarget then
      -- local mobId = GetV(V_HOMUNTYPE, AttackTarget)
      prevAttackTarget = AttackTarget
      boltCounter = event.target.mobConfig.bolts or 0
    end

    if boltCounter ~= 0 and World.mySP >= (20 + 2 * capriceLvl) and SkillDelay <
      World.tick then
      SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
      SetSkillDelay(caprice[capriceLvl].delay)
      event.usedSkill = true
    end
  end

  next()
end

function RangedAttackDuringMelee(event, next)

  if AttackTarget ~= prevAttackTarget then
    -- local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = event.target.mobConfig.bolts or 0
  end
  if boltCounter ~= 0 and (SkillDelay < World.tick or boltCounter < 0) and
    World.mySP >= (20 + 2 * capriceLvl) then
    SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
    SetSkillDelay(caprice[capriceLvl].delay)
    event.usedSkill = true
  end

  next()
end
