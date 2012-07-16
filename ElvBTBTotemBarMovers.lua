_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local E, L, V, DF, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ElvBTBTotem = nil
local ElvBTBTotemBarMovers = {}

function ElvBTBTotemBarMovers:createMover(bar)
  ElvBTBTotem = _G["ElvBTBTotem"]  
  
  E:CreateMover(bar, format(bar:GetName().."Mover"), ElvBTBTotem.TOTEM_SCHOOL_NAMES[bar.totemType].." Totem Bar") 
end

_G["ElvBTBTotemBarMovers"] = ElvBTBTotemBarMovers