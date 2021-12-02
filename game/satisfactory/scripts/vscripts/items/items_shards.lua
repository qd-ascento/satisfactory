LinkLuaModifier("modifier_ore_auto", "items/items_shards.lua", LUA_MODIFIER_MOTION_NONE)

ore_mining = class({
	GetIntrinsicModifierName = function() return "modifier_ore_auto" end,
})

	function ore_mining:OnSpellStart()
	
		local caster = self:GetCaster()
		--if not caster:IsTrueHero() then return end
		local ability = self
		local value = self:GetSpecialValueFor("produce")
		local time = self:GetSpecialValueFor("time")

		local count = ability:GetLevelSpecialValueFor("produce", ability:GetLevel())

		--if unit == ("npc_stone_mine_build1") then

			local newItem = CreateItem("item_stone_core", caster, caster)

		--elseif unit == ("npc_iron_mine_build1") then

			--local newItem = CreateItem("item_iron_core", caster, caster)

		--end

			for i=0,count-1 do
			caster:AddItem(newItem)
			end

	end

	modifier_ore_auto = class({
	IsHidden = function() return true end,
})

if IsServer() then
	function modifier_ore_auto:OnCreated()
		self:StartIntervalThink(0.01)
	end

	function modifier_ore_auto:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()
		if parent:IsAlive() then
				if ability:GetAutoCastState() and not parent:IsChanneling() and not parent:IsInvisible() and not (parent:GetCurrentActiveAbility() and parent:GetCurrentActiveAbility():IsInAbilityPhase()) then
					parent:CastAbilityNoTarget(ability, parent:GetPlayerOwnerID())
				end
		end
	end
end