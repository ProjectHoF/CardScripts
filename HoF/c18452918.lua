--초띠용능력
function c18452918.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetOperation(c18452918.activate)
	c:RegisterEffect(e1)
	if c18452918.counter==nil then
		c18452918.counter=true
		c18452918[0]=0
		c18452918[1]=0
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		e2:SetOperation(c18452918.resetcount)
		Duel.RegisterEffect(e2,0)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_RELEASE)
		e3:SetOperation(c18452918.addcount)
		Duel.RegisterEffect(e3,0)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e4:SetCode(EVENT_DISCARD)
		e4:SetOperation(c18452918.addcount)
		Duel.RegisterEffect(e4,0)
	end
end
function c18452918.resetcount(e,tp,eg,ep,ev,re,r,rp)
	c18452918[0]=0
	c18452918[1]=0
end
function c18452918.addcount(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		local pl=tc:GetPreviousLocation()
		if pl==LOCATION_MZONE and tc:GetPreviousRaceOnField()==RACE_REPTILE then
			local p=tc:GetReasonPlayer()
			c18452918[p]=c18452918[p]+1
		elseif pl==LOCATION_HAND and tc:IsType(TYPE_MONSTER) and tc:GetOriginalRace()==RACE_REPTILE then
			local p=tc:GetPreviousControler()
			c18452918[p]=c18452918[p]+1
		end
		tc=eg:GetNext()
	end
end
function c18452918.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c18452918.droperation)
	Duel.RegisterEffect(e1,tp)
end
function c18452918.droperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,18452918)
	Duel.Draw(tp,c18452918[tp],REASON_EFFECT)
end
