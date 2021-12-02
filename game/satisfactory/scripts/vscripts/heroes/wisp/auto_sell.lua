LinkLuaModifier("modifier_auto_sell", "heroes/wisp/auto_sell.lua", LUA_MODIFIER_MOTION_NONE)

auto_sell = class({
	GetIntrinsicModifierName = function() return "modifier_auto_sell" end,
})

	function auto_sell:OnSpellStart()
	
		local caster = self:GetCaster()
		--if not caster:IsTrueHero() then return end
		local ability = self
		local sellable = "item_stone_core"

	
					--local count_stone = caster:GetStackCount(sellable)

if  caster:HasItemInInventory (sellable) then
        for i=0, 8, 1 do
            local sell_item = caster:GetItemInSlot(i)
            if sell_item ~= nil then
                if sell_item:GetName () == sellable then
                    caster:SellItem (sell_item)
                end
            end
        end
    end

					--local give_money = sellable:GetSpecialValueFor("cost")
					--hero:ModifyGold(give_money, false, 0)

end

	modifier_auto_sell = class({
	IsHidden = function() return true end,
})

if IsServer() then
	function modifier_auto_sell:OnCreated()
		self:StartIntervalThink(0.01)
	end

	function modifier_auto_sell:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()
		if parent:IsAlive() then
				if ability:GetAutoCastState() and not parent:IsChanneling() and not parent:IsInvisible() and not (parent:GetCurrentActiveAbility() and parent:GetCurrentActiveAbility():IsInAbilityPhase()) then
					parent:CastAbilityNoTarget(ability, parent:GetPlayerOwnerID())
				end
		end
	end
end