--LL(?ºÏù¥???ºÏù¥?∏Îãù) - ?¨Î°ú?∏Ïä§?ºÏñ¥ ?îÏΩò
function c112400114.initial_effect(c)
	Synchro.AddProcedure(c,c112400114.synfilter,1,1,aux.NonTuner(c112400114.synfilter2),2,2)
	local e10=Effect.CreateEffect(c)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_SPSUMMON_CONDITION)
	e10:SetValue(aux.synlimit)
	c:RegisterEffect(e10)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCondition(c112400114.spcon)
	e1:SetTarget(c112400114.sptg)
	e1:SetOperation(c112400114.spop)
	c:RegisterEffect(e1)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c112400114.sumcon)
	e2:SetOperation(c112400114.sumsuc)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c112400114.exatkcon)
	e3:SetCost(c112400114.exatkcost)
	e3:SetOperation(c112400114.exatkop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(s.valcheck)
	e4:SetLabelObject(e4)
	c:RegisterEffect(e4)
end
function c112400114.synfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_SYNCHRO)
end
function c112400114.synfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_SYNCHRO)
end
function c112400114.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c112400114.mfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c112400114.spcon(e,tp,eg,ep,ev,re,r,rp)
	return (not e:GetLabel()==1 or not e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO) and Duel.GetTurnPlayer()==tp
end
function c112400114.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end 
end
function c112400114.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,0,REASON_EFFECT+REASON_RULE)
end
function c112400114.mfilter(c)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_SYNCHRO)
end
function c112400114.efilter(e,re)
	return e:GetHandlerPlayer()~=re:GetOwnerPlayer()
end
function c112400114.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400114.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(c112400114.actlimit)
end
function c112400114.actlimit(e,re,tp)
	return (not re:GetHandler():IsType(TYPE_TRAP+TYPE_MONSTER+TYPE_SPELL) or not re:IsHasType(EFFECT_TYPE_ACTIVATE)) and re:GetHandlerPlayer()==tp
end
function c112400114.exatkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMaterial():IsExists(c112400114.mfilter,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO and Duel.IsAbleToEnterBP()
end
function c112400114.rfilter(c)
	return c:IsReleasable() and c:IsRace(RACE_WINDBEAST)
end
function c112400114.exatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c112400114.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c112400114.rfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c112400114.exatkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	tc:RegisterEffect(e1)
end