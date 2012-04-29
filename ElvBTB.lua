_, myClassName = UnitClass("player")

local ElvBTBTotemBars = nil

function ElvBTB_OnLoad(self)  -- Runs when it loads
  if myClassName ~= "SHAMAN" then return end
  
  ElvBTBTotemBars = _G["ElvBTBTotemBars"]
  self.barsCreated = false
  
  self:RegisterEvent("PLAYER_LOGIN")
  self:RegisterEvent("SPELLS_CHANGED")
  self:RegisterEvent("PLAYER_TOTEM_UPDATE")
end

function ElvBTB_OnEvent(self, event, ...)  -- Run when it gets an event
  if myClassName ~= "SHAMAN" then return end
  
  if not self.barsCreated then
    if event == "PLAYER_LOGIN" then
      ElvBTB.barsCreated = ElvBTBTotemBars:createBars()
    end
  else
    if event == "SPELLS_CHANGED" then
      ElvBTBTotemBars:updateBars(true)
    elseif event == "PLAYER_TOTEM_UPDATE" then
      ElvBTBTotemBars:updateBars()
    end
  end
end

function ElvBTB_OnUpdate(self)  -- Run on ticks
  if myClassName ~= "SHAMAN" then return end
  
  if ElvBTBTotemBars.activeTotems then
    ElvBTBTotemBars:updateBars()  -- TODO improve memory usage here
  end
end

_G["ElvBTB"] = ElvBTB