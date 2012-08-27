_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local E, L, V, DF, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

local ElvBTBTotem = nil
local ElvBTBTotemBarCountdowns = {}

function ElvBTBTotemBarCountdowns:createCountdown(bar)
  ElvBTBTotem = _G["ElvBTBTotem"]  
  local r, g, b = unpack(ElvBTBTotem.TOTEM_COLORS[bar.totemType])
  
  local countdown = CreateFrame("StatusBar", format(bar:GetName().."Countdown"), bar)
  countdown.bar = bar
  
  countdown:SetWidth(bar.countdownWidth)
  countdown:CreateBackdrop("Default")
  countdown:SetStatusBarTexture(E['media'].blankTex)
  countdown:GetStatusBarTexture():SetHorizTile(false)
  if bar.totemType % 2 == 1 then
    countdown:SetPoint("BOTTOMLEFT", 4, 4)
	countdown:SetHeight(bar.buttonSize-4)
  else
    countdown:SetPoint("BOTTOMLEFT", 4, 5)
	countdown:SetHeight(bar.buttonSize-5)
  end
  
  if bar.totemType == 4 then
	countdown:SetWidth(bar.countdownWidth-0.5)
  end
  
  countdown:SetOrientation("Vertical")
  countdown:SetMinMaxValues(0, 1)
  countdown:SetValue(0)
  countdown:SetStatusBarColor(r, g, b)

  countdown.bg = countdown:CreateTexture(nil, "BORDER")
  countdown.bg:SetAllPoints()
  countdown.bg:SetTexture(E['media'].blankTex)
  countdown.bg:SetVertexColor(r*.3, g*.3, b*.3)

  return countdown
end

function ElvBTBTotemBarCountdowns:updateCountdown(countdown, value, optionsChanged)
  if optionsChanged then
    countdown:SetWidth(countdown.bar.countdownWidth)
    countdown:SetHeight(countdown.bar.buttonSize-4)
  end

  countdown:SetValue(value)
end

_G["ElvBTBTotemBarCountdowns"] = ElvBTBTotemBarCountdowns