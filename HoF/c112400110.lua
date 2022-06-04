--LL(라이트 라이트닝) - 이터널 팔콘
function c112400110.initial_effect(c)
	Synchro.AddProcedure(c,c112400110.synfilter,1,1,aux.NonTuner(c112400110.synfilter2),2,99)
	c:EnableReviveLimit()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(112400110,1))
	e5:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetCountLimit(1,112400110)
	e5:SetCondition(c112400110.atkcon)
	e5:SetOperation(c112400110.atkop)
	c:RegisterEffect(e5)
end
function c112400110.synfilter(c)
	return c:IsRace(RACE_WINDBEAST)
end
function c112400110.synfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c112400110.mfilter(c)
	return c:IsSetCard(0xec8)
end
function c112400110.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsControler(1-tp) and e:GetHandler():GetMaterial():IsExists(c112400110.mfilter,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400110.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local val=bc:GetAttack()
	if c:IsRelateToBattle() and c:IsFaceup() and bc:IsRelateToBattle() and bc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(val)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
