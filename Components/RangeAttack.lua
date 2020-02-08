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
    local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = MobSettings[mobId].bolts or 0
  end
  if boltCounter then
    if World.mySP >= (20 + 2 * capriceLvl) and SkillDelay < World.tick or
      boltCounter < 0 then
      SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
      SetSkillDelay(caprice[capriceLvl].delay)
    end
  end

  next()
end

function RangeAttackDuringChase(event, next)
  local dist = GetDistanceSquared(World.myId, AttackTarget)

  if dist <= 81 then
    if AttackTarget ~= prevAttackTarget then
      local mobId = GetV(V_HOMUNTYPE, AttackTarget)
      prevAttackTarget = AttackTarget
      boltCounter = MobSettings[mobId].bolts or 0
    end

    if boltCounter and World.mySP >= (20 + 2 * capriceLvl) and SkillDelay <
      World.tick then
      SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
      SetSkillDelay(caprice[capriceLvl].delay)
    end
  end

  next()
end

function RangedAttackDuringMelee(event, next)

  if AttackTarget ~= prevAttackTarget then
    local mobId = GetV(V_HOMUNTYPE, AttackTarget)
    prevAttackTarget = AttackTarget
    boltCounter = MobSettings[mobId].bolts or 0
  end
  if boltCounter and World.mySP >= (20 + 2 * capriceLvl) and SkillDelay <
    World.tick then
    TraceAI('bolting')
    SkillObject(World.myId, capriceLvl, 8013, AttackTarget)
    SetSkillDelay(caprice[capriceLvl].delay)
  end

  next()

end
