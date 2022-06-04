--LL(라이트 라이트닝) - 뉴클리어 캐논 팔콘
function c112400112.initial_effect(c)
	Synchro.AddProcedure(c,c112400112.synfilter,1,1,aux.NonTuner(c112400112.synfilter2),1,99)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCondition(c112400112.spcon)
	e1:SetOperation(c112400112.spop)
	c:RegisterEffect(e1)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c112400112.atkcon)
	e3:SetTarget(c112400112.atktg)
	e3:SetOperation(c112400112.atkop)
	c:RegisterEffect(e3)
end
function c112400112.synfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_SYNCHRO)
end
function c112400112.synfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_SYNCHRO)
end
function c112400112.spcon(e,tp,eg,ep,ev,re,r,rp)
	 return (not e:GetHandler():GetMaterial():IsExists(c112400112.mfilter,1,nil) or not e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO) and Duel.GetTurnPlayer()==tp
end
function c112400112.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,0,REASON_EFFECT+REASON_RULE)
end
function c112400112.mfilter(c)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_SYNCHRO)
end
function c112400112.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMaterial():IsExists(c112400112.mfilter,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400112.dfilter(c)
	return c:IsDestructable()
end
function c112400112.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400112.dfilter,tp,0,LOCATION_ONFIELD,1,nil) and Duel.IsExistingMatchingCard(c112400112.mfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local d=Duel.GetMatchingGroupCount(c112400112.mfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,d,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c112400112.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(sg,REASON_EFFECT)
end
