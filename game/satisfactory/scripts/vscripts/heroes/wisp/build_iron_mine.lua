build_iron_mine = class({})


if IsServer() then
	function build_iron_mine:OnSpellStart()

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local ability = self
	local target_origin = target:GetAbsOrigin()
	local direction = target:GetForwardVector()
	local eidelon_level = ability:GetLevel()
	
	-- Determines which unit to spawn
	local unit_name
	if eidelon_level == 1 then
		unit_name = "npc_iron_mine_build1"
	elseif eidelon_level == 2 then
		unit_name = "npc_iron_mine_build1"
	elseif eidelon_level == 3 then
		unit_name = "npc_iron_mine_build1"
	elseif eidelon_level == 4 then
		unit_name = "npc_iron_mine_build1"
	end	
	
	if eidelon_level >= 1 and eidelon_level <= 4 then
		-- Takes note of the caster for when the eidelons split
		ability.caster = caster
		-- Kills the target unit
		target:ForceKill(true)
		-- Gives the caster the gold bounty
		--caster:SetGold(caster:GetGold() + bounty, false)
		-- Splits the experience among heroes in range
		--for i,unit in ipairs(units) do
			--unit:AddExperience(shared_xp, 0, false, false)
		--end
		-- Creates the eidelons on the target and facing the same direction
		
			local eidelon = CreateUnitByName(unit_name, target_origin, true, caster, nil, caster:GetTeam())
			eidelon:SetForwardVector(direction)
			eidelon:SetControllableByPlayer(caster:GetPlayerID(), true)
			eidelon:SetOwner(caster)
		
			-- Adds the green duration circle, and kills the eidelon after the duration ends
			--eidelon:AddNewModifier(eidelon, nil, "modifier_kill", {duration = duration})
			-- Phases the eidelon for a short period so there is no unit collision
			--eidelon:AddNewModifier(eidelon, nil, "modifier_phased", {duration = 0.03})
			-- Applies the modifier to count each eidelon's attacks
			--ability:ApplyDataDrivenModifier( eidelon, eidelon, "modifier_check_attacks", {} )
			-- Takes note of the game time, so we know the duration for the split eidelons
			--eidelon.time = GameRules:GetGameTime()
		
	end
end
end
