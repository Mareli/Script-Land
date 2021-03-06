--[[ WoTD License - 
This software is provided as free and open source by the
team of The WoTD Team. This script was written and is
protected by the GPL v2. Please give credit where credit
is due, if modifying, redistributing and/or using this 
software. Thank you.
Thank: WoTD Team; for the Script
~~End of License... Please Stand By...
-- WoTD Team, Janurary 19, 2010. ]]

local UNIT_FLAG_NOT_SELECTABLE = 33554432

function Jaraxxus_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "You face Jaraxxus, eredar lord of the Burning Legion!")
	Unit:PlaySoundToSet(16144)
	Unit:RegisterEvent("Jaraxxus_FelFireball", 10000, 1)
	Unit:RegisterEvent("Jaraxxus_IncinerateFlesh", math.random(17500,22500), 0)
	Unit:RegisterEvent("Jaraxxus_LegionFlame", 30000, 0)
	Unit:RegisterEvent("Jaraxxus_InfernalVulcano", 40000, 1)
	Unit:RegisterEvent("Jaraxxus_NetherPower", 15000, 0)
end

RegisterUnitEvent(34780, 1, "Jaraxxus_OnCombat")
RegisterUnitEvent(54780, 1, "Jaraxxus_OnCombat")

function Jaraxxus_FelFireball(Unit, Event)
	if(Unit:GetMainTank() ~= nil) then
		Unit:FullCastSpellOnTarget(66532, Unit:GetMainTank())
	end
	Unit:RegisterEvent("Jaraxxus_FelLightning", 10000, 1)
end

function Jaraxxus_FelLightning(Unit, Event)
	if(Unit:GetMainTank() ~= nil) then
		Unit:FullCastSpellOnTarget(66528, Unit:GetMainTank())
	end
	Unit:RegisterEvent("Jaraxxus_FelFireball", 10000, 1)
end

function Jaraxxus_IncinerateFlesh(Unit, Event)
	if(Unit:GetRandomPlayer(0) ~= nil) then
		Unit:CastSpellOnTarget(66237, Unit:GetRandomPlayer(0))
		Unit:SendChatMessage(14, 0, "FLESH FROM BONE!")
		Unit:PlaySoundToSet(16149)
	end
end

function Jaraxxus_NetherPower(Unit, Event)
	Unit:CastSpell(67108)
end

function Jaraxxus_LegionFlame(Unit, Event)
	local randomplr_0 = Unit:GetRandomPlayer(0)
	if(randomplr_0 ~= nil) then
		Unit:SpawnCreature(34803, randomplr_0:GetX(), randomplr_0:GetY(), randomplr_0:GetZ(), randomplr_0:GetO(), 14, 60000)
		Unit:RegisterEvent("LegionFlame_Next", 1000, 5)
	end
end

function LegionFlame_Next(Unit, Event)
	local randomplr_0 = Unit:GetRandomPlayer(0)
	if(randomplr_0 ~= nil) then
		Unit:SpawnCreature(34803, randomplr_0:GetX(), randomplr_0:GetY(), randomplr_0:GetZ(), randomplr_0:GetO(), 14, 60000)
	end
end

function LegionFlame_OnSpawn(Unit, Event)
	Unit:Root()
	Unit:SpawnGameObject(34802, Unit:GetX(), Unit:GetY(), Unit:GetZ(), Unit:GetO(), 60000)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
end

RegisterUnitEvent(34803, 18, "LegionFlame_OnSpawn")

function Jaraxxus_InfernalVulcano(Unit, Event)
	Unit:SendChatMessage(14, 0, "INFERNO!")
	Unit:PlaySoundToSet(16151)
	local randomplr_0 = Unit:GetRandomPlayer(0)
	Unit:SpawnCreature(34804, randomplr_0:GetX(), randomplr_0:GetY(), randomplr_0:GetZ(), randomplr_0:GetO(), 35, 10000)
	Unit:RegisterEvent("Jaraxxus_DemonPortal", 40000, 1)
end

function InfernalVolcano_OnSpawn(Unit, Event)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	Unit:Root()
	Unit:SetCombatTargetingCapable(1)
	Unit:SetCombatSpellCapable(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatRangedCapable(1)
	Unit:SetCombatCapable(1)
	Unit:RegisterEvent("InfernalVolcano_SpawnInfernal", 2000, 5)
end

RegisterUnitEvent(34804, 18, "InfernalVolcano_OnSpawn")

function InfernalVolcano_SpawnInfernal(Unit, Event)
	local spawnpos=math.random(1,5)
	if(spawnpos == 1) then
		Unit:SpawnCreature(34805, Unit:GetX()+2, Unit:GetY(), Unit:GetZ(), Unit:GetO(), 16, 0)
	elseif(spawnpos == 2) then
		Unit:SpawnCreature(34805, Unit:GetX()+2, Unit:GetY()+2, Unit:GetZ(), Unit:GetO(), 16, 0)
	elseif(spawnpos == 3) then
		Unit:SpawnCreature(34805, Unit:GetX(), Unit:GetY()+2, Unit:GetZ(), Unit:GetO(), 16, 0)
	elseif(spawnpos == 4) then
		Unit:SpawnCreature(34805, Unit:GetX()-2, Unit:GetY()-2, Unit:GetZ(), Unit:GetO(), 16, 0)
	elseif(spawnpos == 5) then
		Unit:SpawnCreature(34805, Unit:GetX(), Unit:GetY()-2, Unit:GetZ(), Unit:GetO(), 16, 0)
	end
end

function FelflameInfernal_OnCombat(Unit, Event)
	Unit:RegisterEvent("FelflameInfernal_FelInferno", 24000, 0)
end

function FelflameInfernal_FelInferno(Unit, Event)
	Unit:Root()
	if(Unit:GetRandomPlayer(1) ~= nil) then
		Unit:FullCastSpell(67047, Unit:GetRandomPlayer(1))
	end
	Unit:RegisterEvent("FelflameInfernal_Unroot", 6000, 1)
end

function FelflameInfernal_Unroot(Unit, Event)
	Unit:Unroot()
end

function FelflameInfernal_Wipe(Unit, Event)
	Unit:RemoveEvents()
	Unit:Despawn(1, 0)
end

RegisterUnitEvent(34805, 1, "FelflameInfernal_OnCombat")
RegisterUnitEvent(34805, 3, "FelflameInfernal_Wipe")
RegisterUnitEvent(34805, 4, "FelflameInfernal_Wipe")

function Jaraxxus_DemonPortal(Unit, Event)
	Unit:SendChatMessage(14, 0, "Come forth sister! Your master calls!")
	Unit:PlaySoundToSet(16150)
	local randomplr_0 = Unit:GetRandomPlayer(0)
	Unit:SpawnCreature(34806, randomplr_0:GetX(), randomplr_0:GetY(), randomplr_0:GetZ(), randomplr_0:GetO(), 35, 4000)
	Unit:RegisterEvent("Jaraxxus_InfernalVulcano", 40000, 1)
end

function DemonPortal_OnSpawn(Unit, Event)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE)
	Unit:Root()
	Unit:SetCombatTargetingCapable(1)
	Unit:SetCombatSpellCapable(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatRangedCapable(1)
	Unit:SetCombatCapable(1)
	Unit:RegisterEvent("DemonPortal_SpawnDemon", 2000, 1)
end

RegisterUnitEvent(34806, 18, "DemonPortal_OnSpawn")

function DemonPortal_SpawnDemon(Unit, Event)
	Unit:SpawnCreature(34808, Unit:GetX()+2, Unit:GetY(), Unit:GetZ(), Unit:GetO(), 16, 0)
end

function MistressOfPain_OnCombat(Unit, Event)
	Unit:RegisterEvent("MistressOfPain_ShivanSlash", 9000, 0)
	Unit:RegisterEvent("MistressOfPain_SpinningPainSpike", 25000, 0)
end

function MistressOfPain_ShivanSlash(Unit, Event)
	if(Unit:GetMainTank() ~= nil) then
		Unit:FullCastSpellOnTarget(67098, Unit:GetMainTank())
	end
end

function MistressOfPain_SpinningPainSpike(Unit, Event)
	if(Unit:GetRandomPlayer(0) ~= nil) then
		Unit:CastSpellOnTarget(66316, Unit:GetRandomPlayer(0))
	end
end

function MistressOfPain_Wipe(Unit, Event)
	Unit:RemoveEvents()
	Unit:Despawn(1, 0)
end

RegisterUnitEvent(34808, 1, "MistressOfPain_OnCombat")
RegisterUnitEvent(34808, 3, "MistressOfPain_Wipe")
RegisterUnitEvent(34808, 4, "MistressOfPain_Wipe")

function Jaraxxus_OnLeaveCombat(Unit, Event)
	Unit:SpawnCreature(35035, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	Unit:RemoveEvents()
	Unit:Despawn(1, 0)
end

function Jaraxxus_OnDeath(Unit, Event)
	Unit:SpawnCreature(35766, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	Unit:SpawnCreature(360958, 554.412, 94.4594, 396.096, 5.49938, 35, 0)
	Unit:SendChatMessage(14, 0, "Another will take my place. Your world is doomed.")
	Unit:PlaySoundToSet(16147)
end

RegisterUnitEvent(34780, 2, "Jaraxxus_OnLeaveCombat")
RegisterUnitEvent(54780, 2, "Jaraxxus_OnLeaveCombat")
RegisterUnitEvent(34780, 4, "Jaraxxus_OnDeath")
RegisterUnitEvent(54780, 4, "Jaraxxus_OnDeath")