--LL(라이트 라이트닝) - 라이트닝 팔콘
function c112400107.initial_effect(c)
	Synchro.AddProcedure(c,c112400107.synfilter,1,1,aux.NonTuner(c112400107.synfilter2),1,99)
	c:EnableReviveLimit()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetCondition(c112400107.atkcon)
	e2:SetValue(c112400107.atkfilter)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c112400107.cost)
	e1:SetOperation(c112400107.operation)
	c:RegisterEffect(e1)
end
function c112400107.synfilter(c)
	return c:IsRace(RACE_WINDBEAST)
end
function c112400107.synfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c112400107.atkfilter(e,c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c112400107.atkcon(e,c)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400107.rfilter(c)
	return c:IsReleasable() and c:IsRace(RACE_WINDBEAST)
end
function c112400107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400107.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c112400107.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c112400107.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(3000)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
