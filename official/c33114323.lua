--メタルシルバー・アーマー
--Effect is not fully implemented
local s,id=GetID()
function s.initial_effect(c)
	aux.AddEquipProcedure(c)
	--atk target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(s.efftg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function s.efftg(e,c)
	return c~=e:GetHandler():GetEquipTarget() and c:IsType(TYPE_MONSTER)
end
