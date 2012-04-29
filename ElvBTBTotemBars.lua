_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local LibActionButton = LibStub("LibActionButton-1.0")

local ElvBTBTotem = nil
local ElvBTBTotemBarCountdown = nil
local ElvBTBTotemBarButtons = nil
local ElvBTBTotemBars = {}

function ElvBTBTotemBars:createBars()
  ElvBTBTotem = _G["ElvBTBTotem"]
  ElvBTBTotemBarButtons = _G["ElvBTBTotemBarButtons"]

  
  ElvBTBTotemBars.validTotems = ElvBTBTotem:validTotems()
  local numOfTotemsType = table.getn(ElvBTBTotemBars.validTotems)
  
  hardcodedPositions = {
    {-230, -537},
    {-195, -572},
    {-19, -537},
    {-2, -572}
  }
   
  for i=1,numOfTotemsType do
    ElvBTBTotemBars[i] = ElvBTBTotemBars:createBar(i, unpack(hardcodedPositions[i]))
  end
  
  return true
end

function ElvBTBTotemBars:createBar(totemType, x, y)
  local bar = CreateFrame("Frame", "ElvBTBTotemBar"..totemType, UIParent, "SecureHandlerStateTemplate")
  
  bar.totemType = totemType
  bar.spellIds = ElvBTBTotemBars.validTotems[bar.totemType]
  bar.numOfTotems = table.getn(bar.spellIds)  
  bar.buttonSize = 30
  bar.countdownWidth = 5
  bar.showBackdrop = false
    
  if bar.showBackdrop then bar:CreateBackdrop("Default") end
  bar:SetFrameStrata("MEDIUM")
  bar:SetWidth((bar.numOfTotems*bar.buttonSize)+((bar.numOfTotems-1)*5)+4+bar.countdownWidth+8)
  bar:SetHeight(bar.buttonSize+4)
  bar:SetPoint("CENTER", x, y)
  
  bar.buttons = ElvBTBTotemBarButtons:createButtons(bar)
  bar.countdown = ElvBTBTotemBarCountdowns:createCountdown(bar)
  
  return bar
end

function ElvBTBTotemBars:updateBars(spellsChanged)
  ElvBTBTotemBars.validTotems = ElvBTBTotem.validTotems()
  local numOfTotemsType = table.getn(ElvBTBTotemBars.validTotems)
  
  ElvBTBTotemBars.activeTotems = false
  
  for i=1,numOfTotemsType do
    ElvBTBTotemBars:updateBar(ElvBTBTotemBars[i], (spellsChanged and not UnitAffectingCombat("player")))
    ElvBTBTotemBars.activeTotems = ElvBTBTotemBars.activeTotems or ElvBTBTotemBars[i].activeTotem
  end
end

function ElvBTBTotemBars:updateBar(bar, spellsChanged)
  if spellsChanged then
    bar.spellIds = ElvBTBTotemBars.validTotems[bar.totemType]
    bar.numOfTotems = table.getn(bar.spellIds)
  
    bar:SetWidth((bar.numOfTotems*bar.buttonSize)+((bar.numOfTotems-1)*5)+4+bar.countdownWidth+8)
  
    ElvBTBTotemBarButtons:updateButtons(bar, bar.buttons)
  end
  
  haveTotem, _, startTime, duration, _ = GetTotemInfo(bar.totemType)
  if startTime > 0 then
    ElvBTBTotemBarCountdowns:updateCountdown(bar.countdown, 1-((GetTime()-startTime)/duration))
    bar.activeTotem = true
  else
    ElvBTBTotemBarCountdowns:updateCountdown(bar.countdown, 0)
    bar.activeTotem = false
  end
end

_G["ElvBTBTotemBars"] = ElvBTBTotemBars
