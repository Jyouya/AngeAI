V_OWNER = 0
V_POSITION = 1
V_TYPE = 2
V_MOTION = 3
V_ATTACKRANGE = 4
V_TARGET = 5
V_SKILLATTACKRANGE = 6
V_HOMUNTYPE = 7
V_HP = 8
V_SP = 9
V_MAXHP = 10
V_MAXSP = 11
V_MERTYPE = 12

LIF = 1
AMISTR = 2
FILIR = 3
VANILMIRTH = 4
LIF2 = 5
AMISTR2 = 6
FILIR2 = 7
VANILMIRTH2 = 8
LIF_H = 9
AMISTR_H = 10
FILIR_H = 11
VANILMIRTH_H = 12
LIF_H2 = 13
AMISTR_H2 = 14
FILIR_H2 = 15
VANILMIRTH_H2 = 16

NOVICE = 0
SWORDSMAN = 1
MAGE = 2
ARCHER = 3
ACOYLTE = 4
MERCHANT = 5
THIEF = 6
KNIGHT = 7
PRIEST = 8
WIZARD = 9
BLACKSMITH = 10
HUNTER = 11
ASSASSIN = 12

CRUSADER = 14
MONK = 15
SAGE = 16
ROGUE = 17
ALCHEMIST = 18
BARD = 19
DANCER = 20

SUPERNOVICE = 23
GUNSLINGER = 24
NINJA = 25

NOVICE_HIGH = 4001
SWORDSMAN_HIGH = 4002
NAGE_HIGH = 4003
ARCHER_HIGH = 4004
ACOLYTE_HIGH = 4005
MERCHANT_HIGH = 4006
THIEF_HIGH = 4007
LORD_KNIGHT = 4008
HIGH_PRIEST = 4009
HIGH_WIZARD = 4010
WHITESMITH = 4011
SNIPER = 4012
ASSASSIN_CROSS = 4013

PALADIN = 4015
CHAMPION = 4016
PROFESSOR = 4017
STALKER = 4018
CREATOR = 4019
CLOWN = 4020
GYPSY = 4021

BABY_NOVICE = 4023
BABY_SWORDSMAN = 4024
BABY_MAGE = 4025
BABY_ARCHER = 4026
BABY_ACOLYTE = 4027
BABY_MERCHANT = 4028
BABY_THIEF = 4029
BABY_KNIGHT = 4030
BABY_PRIEST = 4031
BABY_WIZARD = 4032
BABY_BLACKSMITH = 4033
BABY_HUNTER = 4034
BABY_ASSASSIN = 4035 -- OMG HIDE THE CHILDREN

BABY_CRUSADER = 4037
BABY_MONK = 4038
BABY_SAGE = 4039
BABY_ROGUE = 4040
BABY_ALCHEMIST = 4041
BABY_BARD = 4042
BABY_DANCER = 4043

SUPER_BABY = 4045
TAEKWON_KID = 4046
TAEKWON_MASTER = 4047
SOUL_LINKER = 4048

--------------------------Pathoth's Detailed motion list.
--still do not know motions 14,15,29, and 42+  . if you know what these are, please contact me.
--ARG can't even detect sonic blow, cart boost, or stun/freeze/stone/silence? LAME
--some motions can be used to assume enemy class, but none of the important ones.
MOTION_STAND = 0 	-- Standing still
MOTION_MOVE = 1 	-- Moving
MOTION_ATTACK = 2 	-- Attacking
MOTION_DEAD = 3 	-- Laying dead
MOTION_DAMAGE = 4 	-- Taking damage
MOTION_BENDDOWN = 5 	-- Pick up item, set trap
MOTION_SIT = 6 		-- Sitting down
MOTION_SKILL = 7 	-- Used a skill
MOTION_CASTING = 8 	-- Casting a skill
MOTION_VULCAN = 9 	-- Arrow Vulcan, Shadow Slash
MOTION_SLEEP = 10	-- Sleep status (only sleep status is detected? ....)
MOTION_SPIRAL = 11	-- spiral pierce
MOTION_TOSS = 12	-- throw stone, sand attack, venom knife, sheild charge (NOT BOOMERANG!), sheild chain, summon flora, potion pitcher, demonstration, acid terror, ?spear boomerang?
MOTION_COUNTER = 13 	-- Counter-attack
--??
--??
MOTION_DANCE = 16	-- dancer dances, duets
MOTION_SING = 17 	-- bard songs only. no frost joke
MOTION_SHARPSHOOT = 18	-- sharpshooting
MOTION_JUMP_UP = 19 	-- TaeKwon Kid Leap -- rising
MOTION_JUMP_FALL= 20 	-- TaeKwon Kid Leap -- falling
MOTION_PWHIRL = 21	-- TeaKwon prepare whirlwind kick stance
MOTION_PAXE = 22	-- TeaKwon prepare axe kick stance
MOTION_SOULLINK = 23	-- TeaKwon prepare round kick stance, ??Soul Link??
MOTION_PCOUNTER = 24	-- TeaKwon prepare counter kick stance
MOTION_TUMBLE = 25	-- Tumbling / TK Kid Leap Landing
MOTION_COUNTERK = 26	-- TeaKwon counter kick
MOTION_FLYK = 27	-- TeaKwon flying kick
MOTION_BIGTOSS = 28 	-- A heavier toss (slim potions / acid demonstration) 
--??
MOTION_WHIRLK = 30	-- TeaKwon whirlwind kick
MOTION_AXEK = 31	-- TeaKwon axe kick
MOTION_ROUNDK = 32	-- TeaKwon roundhouse kick
MOTION_COMFORT = 33	-- comfort of sun/moon/star
MOTION_HEAT = 34	-- heat activation? not flame dmg
MOTION_NINJAGROUND = 35	-- ninja illusionary shadow, water escape, mist slash, dragon fire formation, crimson fire formation, ice spear, (ninja puts hand on ground)
MOTION_NINJAHAND = 36	-- ninja throw kunai, shuriken, cicada, throw zeny, soul, (ninja says "talk to the hand")
MOTION_NINJACAST = 37	-- ninja casting a spell. ninjas are too good for the normal cast motion
MOTION_GUNTWIN = 38	-- gunslinger shows off his twin guns? flip coin, inc accuracy.. gatling fever, desperado,
MOTION_GUNFLIP = 39	-- gunslinger flips out... a coin?
MOTION_GUNSHOW = 40	-- gunslinger shows the big gun. cracker, gunslinger mine... ?fullbuster?
MOTION_GUNCAST = 41	-- gunslinger casts a spell

NONE_CMD			= 0
MOVE_CMD			= 1
STOP_CMD			= 2
ATTACK_OBJECT_CMD	= 3
ATTACK_AREA_CMD		= 4
PATROL_CMD			= 5
HOLD_CMD			= 6
SKILL_OBJECT_CMD	= 7
SKILL_AREA_CMD		= 8
FOLLOW_CMD			= 9