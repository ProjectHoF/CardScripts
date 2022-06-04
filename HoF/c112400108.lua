--LL(라이트 라이트닝) - 썬더 팔콘
function c112400108.initial_effect(c)
	Synchro.AddProcedure(c,c112400108.synfilter,1,1,aux.NonTuner(c112400108.synfilter2),2,99)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c112400108.dacon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c112400108.descon)
	e2:SetTarget(c112400108.destg1)
	e2:SetOperation(c112400108.desop1)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c112400108.descon2)
	e3:SetCost(c112400108.descost)
	e3:SetTarget(c112400108.destg2)
	e3:SetOperation(c112400108.desop2)
	c:RegisterEffect(e3)
end
function c112400108.filter3(c)
	return c:IsSetCard(0xec8)
end
function c112400108.dacon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400108.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetMaterial():IsExists(c112400108.filter3,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400108.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMaterial():IsExists(c112400108.filter3,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400108.destg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c112400108.desop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c112400108.rfilter(c)
	return c:IsReleasable() and c:IsRace(RACE_WINDBEAST)
end
function c112400108.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400108.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c112400108.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c112400108.filter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c112400108.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400108.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c112400108.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c112400108.desop2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c112400108.filter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end
function c112400108.synfilter(c)
	return c:IsRace(RACE_WINDBEAST)
end
function c112400108.synfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end