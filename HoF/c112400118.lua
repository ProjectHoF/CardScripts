--LL(라이트 라이트닝) - 섬광의 동조
function c112400118.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c112400118.target)
	e1:SetCountLimit(1,112400118)
	e1:SetOperation(c112400118.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,112400123+EFFECT_COUNT_CODE_DUEL)
	e2:SetCost(c112400118.thcost)
	e2:SetTarget(c112400118.tg)
	e2:SetOperation(c112400118.op)
	c:RegisterEffect(e2)
end
function c112400118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c112400118.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c112400118.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c112400118.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c112400118.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,g1:GetCount(),0,0)
end
function c112400118.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
function c112400118.filter1(c,e,tp)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c112400118.filter2(c,e,tp)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c112400118.rfilter(c)
	return c:IsReleasable() and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c112400118.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400118.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c112400118.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c112400118.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
end
function c112400118.op(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return c:IsLocation(LOCATION_GRAVE) end
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,e:GetHandler())
end