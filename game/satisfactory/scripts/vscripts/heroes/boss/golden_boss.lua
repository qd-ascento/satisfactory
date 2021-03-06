golden_boss = class({})
johny_book = class({})

function golden_boss:OnSpellStart()
	
	local caster = self:GetCaster()
	--local johny_book = "johny_book"
	if caster:FindAbilityByName("up_agi") == nil and caster:FindAbilityByName("up_int") == nil then
		caster:RemoveAbility("up_str")
		caster:AddAbility("up_agi")
		caster:FindAbilityByName("up_agi"):SetLevel(1)
	elseif caster:FindAbilityByName("up_str") == nil and caster:FindAbilityByName("up_int") == nil then
		caster:RemoveAbility("up_agi")
		caster:AddAbility("up_int")
		caster:FindAbilityByName("up_int"):SetLevel(1)
	elseif caster:FindAbilityByName("up_str") == nil and caster:FindAbilityByName("up_agi") == nil then
		caster:RemoveAbility("up_int")
		caster:AddAbility("up_str")
		caster:FindAbilityByName("up_str"):SetLevel(1)
	end

	--caster:FindAbilityByName(give_book):SetLevel(1)

end

function golden_boss:GetIntrinsicModifierName()
	return "modifier_golden_boss"
end

modifier_golden_boss = class({

	DeclareFunctions = function(self) return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_CREATED,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}end,
})
----------------------------------------------------------
function modifier_golden_boss:GetAbsoluteNoDamageMagical()
	return 1
end
-------------------------------------------------------
function modifier_golden_boss:GetAbsoluteNoDamagePure()
	return 1
end

----------------------------------------------
	function modifier_golden_boss:OnCreated()
		local parent = self:GetParent()
		if not parent:HasModifier("modifier_golden_boss") then
			parent:AddNewModifier(parent, self:GetAbility(), "modifier_golden_boss", nil)

		end
		
		parent:AddAbility("up_str")
		parent:FindAbilityByName("up_str"):SetLevel(1)
	end

--------------------------------------------------
function modifier_golden_boss:OnAttackLanded(data)

	local target = data.target
	local attacker = data.attacker
	local ability = data.ability
	local goldDamage = data.damage

		local parent = self:GetParent()
		if not parent:HasModifier("modifier_golden_boss") then
			parent:AddNewModifier(parent, self:GetAbility(), "modifier_golden_boss", nil)
		end

	if parent == attacker and attacker:IsRealHero() and not attacker:IsIllusion() and target:GetUnitName() == "npc_boss1" then

		local gold_now = attacker:GetModifierStackCount("modifier_golden_boss", ability)

			if gold_now < 500000 then

				if goldDamage > 100 then

					attacker:SetModifierStackCount("modifier_golden_boss", attacker, gold_now + 100)

				else

					attacker:SetModifierStackCount("modifier_golden_boss", attacker, gold_now + goldDamage)

				end
				--attacker:SetModifierStackCount("modifier_golden_boss", attacker, gold_now + goldDamage)

			end
	end

		if parent == attacker and attacker:IsRealHero() and not attacker:IsIllusion() and target:GetUnitName() == "npc_boss2" then

		local gold_now = attacker:GetModifierStackCount("modifier_golden_boss", ability)

			if gold_now < 500000 then

				if goldDamage > 200 then

					attacker:SetModifierStackCount("modifier_golden_boss", attacker, gold_now + 200)

				else

					attacker:SetModifierStackCount("modifier_golden_boss", attacker, gold_now + goldDamage)

				end

			end
	end
end



