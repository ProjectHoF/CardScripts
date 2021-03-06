--다원마도원전 크로울리
function c27185075.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_SPELLCASTER),2,2)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27185075,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,27185075)
	e1:SetCondition(c27185075.thcon)
	e1:SetTarget(c27185075.thtg)
	e1:SetOperation(c27185075.thop)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27185075,1))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCountLimit(1)
	e2:SetCondition(c27185075.ntcon)
	e2:SetTarget(c27185075.nttg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_EXTRA)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetCost(c27185075.cost3)
	e3:SetTarget(c27185075.tg3)
	e3:SetOperation(c27185075.op3)
	c:RegisterEffect(e3)
end
function c27185075.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c27185075.thfilter(c)
	return c:IsSetCard(0x306e) and c:IsAbleToHand()
end
function c27185075.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local dg=Duel.GetMatchingGroup(c27185075.thfilter,tp,LOCATION_DECK,0,nil)
		return dg:GetClassCount(Card.GetCode)>=3
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c27185075.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c27185075.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetClassCount(Card.GetCode)>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg1=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg1:GetFirst():GetCode())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg2=g:Select(tp,1,1,nil)
		g:Remove(Card.IsCode,nil,sg2:GetFirst():GetCode())
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg3=g:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		sg1:Merge(sg3)
		Duel.ConfirmCards(1-tp,sg1)
		Duel.ShuffleDeck(tp)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local cg=sg1:Select(1-tp,1,1,nil)
		local tc=cg:GetFirst()
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c27185075.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c27185075.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_SPELLCASTER)
end
function c27185075.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.GetFlagEffect(tp,27185075)<1
	end
	Duel.RegisterFlagEffect(tp,27185075,RESET_CHAIN,0,1)
end
function c27185075.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		return c:IsSpecialSummonable(SUMMON_TYPE_LINK)
	end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,c,1,0,0)
end
function c27185075.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsSpecialSummonable(SUMMON_TYPE_LINK) then
		Duel.SpecialSummonRule(tp,c,SUMMON_TYPE_LINK)
	end
end

