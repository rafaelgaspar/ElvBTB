_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local E, L, DF, G = unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB

local ElvBTBTotem = nil
local ElvBTBTotemBarMovers = {}

function ElvBTBTotemBarMovers:createMover(bar)
  ElvBTBTotem = _G["ElvBTBTotem"]  
  
  local mover = E:CreateMover(bar, format(bar:GetName().."Mover"), ElvBTBTotem.TOTEM_SCHOOL_NAMES[bar.totemType].." Totem Bar") 

  return mover
end

_G["ElvBTBTotemBarMovers"] = ElvBTBTotemBarMovers