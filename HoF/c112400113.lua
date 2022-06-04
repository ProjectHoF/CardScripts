--LL(?ºÏù¥???ºÏù¥?∏Îãù) - ?àÏùº Ï∫êÎÖº ?îÏΩò
function c112400113.initial_effect(c)
	Synchro.AddProcedure(c,c112400113.synfilter,2,2,Synchro.NonTuner(c112400113.matfilter2),1,1)
	c:EnableReviveLimit()
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c112400113.spcon)
	e2:SetTarget(c112400113.sptg)
	e2:SetOperation(c112400113.spop)
	c:RegisterEffect(e2)
	--indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(c112400113.indval)
	c:RegisterEffect(e5)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c112400113.spcon2)
	e3:SetValue(c112400113.val)
	c:RegisterEffect(e3)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e6)
	--double tuner
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetCode(21142671)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_MATERIAL_CHECK)
	e9:SetValue(s.valcheck)
	e9:SetLabelObject(e9)
	c:RegisterEffect(e9)
end
function c112400113.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c112400113.mfilter,1,nil) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
function c112400113.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end
function c112400113.synfilter(c)
	return c:IsRace(RACE_WINDBEAST)
end
function c112400113.matfilter2(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_SYNCHRO)
end
function c112400113.mfilter(c)
	return c:IsSetCard(0xec8) and c:IsType(TYPE_SYNCHRO)
end
function c112400113.spcon(e,tp,eg,ep,ev,re,r,rp)
	return (not e:GetLabel()==1 or not e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO) and Duel.GetTurnPlayer()==tp
end
function c112400113.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end 
end
function c112400113.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,0,REASON_EFFECT+REASON_RULE)
end
function c112400113.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMaterial():IsExists(c112400113.mfilter,1,nil) and e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c112400113.val(e,c)
	return Duel.GetMatchingGroupCount(c112400113.atkfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*500
end
function c112400113.atkfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsType(TYPE_SYNCHRO)
end