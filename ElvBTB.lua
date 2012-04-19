_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local ElvBTBTotem = _G["ElvBTBTotem"]

function ElvBTB_OnLoad(self)  -- Runs when it loads
  self:RegisterEvent("PLAYER_LOGIN")
  self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
end

function ElvBTB_OnEvent(self, event, ...)  -- Run when it gets an event
  if event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_LOGIN" then
    self["validTotems"] = ElvBTBTotem:validTotems()
  end
end

_G["ElvBTB"] = ElvBTB