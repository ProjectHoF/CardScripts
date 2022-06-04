--LL(라이트 라이트닝) - 섬광의 심볼
function c112400116.initial_effect(c)
	c:SetUniqueOnField(1,0,112400116)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c112400116.con)
	e2:SetTarget(c112400116.tg)
	e2:SetOperation(c112400116.op)
	c:RegisterEffect(e2)
end
function c112400116.gfilter(c,tp)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_SYNCHRO) and c:IsControler(tp) and c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400116.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c112400116.gfilter,1,nil,tp)
end
function c112400116.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400116.filter,tp,LOCATION_GRAVE,0,1,nil) end
end
function c112400116.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c112400116.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
function c112400116.filter(c)
	return c:IsSetCard(0xec8) and c:IsAbleToHand()
end