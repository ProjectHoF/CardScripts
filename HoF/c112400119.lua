--LRM(레벨 레볼루션 매직) - 리미티드 에볼루션
function c112400119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c112400119.regcon)
	e1:SetOperation(c112400119.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c112400119.condition)
	e2:SetCost(c112400119.cost)
	e2:SetTarget(c112400119.target)
	e2:SetOperation(c112400119.activate)
	c:RegisterEffect(e2)
end
function c112400119.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFlagEffect(tp,112400119)==0 and Duel.GetCurrentPhase()==PHASE_DRAW
		and c:IsReason(REASON_DRAW) and c:IsReason(REASON_RULE)
end
function c112400119.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.SelectYesNo(tp,aux.Stringid(112400119,0)) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PUBLIC)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_MAIN1)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(112400119,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_MAIN1,0,1)
	end
end
function c112400119.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 and not Duel.CheckPhaseActivity()
end
function c112400119.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(112400119)~=0 end
end
function c112400119.filter1(c,e,tp)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	local l=c:GetLevel()
	return c:IsSetCard(0xec8) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and (not ect or ect>1)
		and Duel.IsExistingMatchingCard(c112400119.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,l)
end
function c112400119.filter2(c,e,tp,mc,l)
	return c:GetLevel()>l and l+3>c:GetLevel() and c:IsSetCard(0xec8) and mc:IsCanBeSynchroMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c112400119.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetFlagEffect(tp,112400119)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c112400119.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c112400119.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,112400119)~=0 then return end
	Duel.RegisterFlagEffect(tp,112400119,0,0,0)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c112400119.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc1=g1:GetFirst()
	if tc1 and Duel.SpecialSummon(tc1,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c112400119.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc1,tc1:GetLevel())
		local tc2=g2:GetFirst()
		if tc2 then
			Duel.BreakEffect()
			tc2:SetMaterial(g1)
			Duel.SendtoGrave(tc1,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
			Duel.SpecialSummon(tc2,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
			tc2:CompleteProcedure()
		end
	end
end
