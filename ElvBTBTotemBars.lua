_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local LibActionButton = LibStub("LibActionButton-1.0")
local E, L, DF, G = unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB

local ElvBTBTotem = nil
local ElvBTBTotemBarButtons = nil
local ElvBTBTotemBarCountdown = nil
local ElvBTBTotemBarMovers = nil
local ElvBTBTotemOptions = nil
local ElvBTBTotemBars = {}

function ElvBTBTotemBars:createBars()
  ElvBTBTotem = _G["ElvBTBTotem"]
  ElvBTBTotemBarButtons = _G["ElvBTBTotemBarButtons"]
  ElvBTBTotemBarCountdown = _G["ElvBTBTotemBarCountdown"]
  ElvBTBTotemBarMovers = _G["ElvBTBTotemBarMovers"]
  ElvBTBTotemOptions = _G["ElvBTBTotemOptions"]
  
  ElvBTBTotemBars.validTotems = ElvBTBTotem:validTotems()
  local numOfTotemsType = table.getn(ElvBTBTotemBars.validTotems)
  
  defaultPositions = {
    {-230, -537},
    {-195, -572},
    {-19, -537},
    {-2, -572}
  }
  
  ElvBTBTotemOptions:createOptions()
  
  for i=1,numOfTotemsType do
    ElvBTBTotemBars[i] = ElvBTBTotemBars:createBar(i, unpack(defaultPositions[i]))
  end
  
  return true
end

function ElvBTBTotemBars:createBar(totemType, x, y)
  local bar = CreateFrame("Frame", "ElvBTBTotemBar"..totemType, UIParent, "SecureHandlerStateTemplate")
  bar:CreateBackdrop("Default")
    
  bar.totemType = totemType
  bar.spellIds = ElvBTBTotemBars.validTotems[bar.totemType]
  bar.numOfTotems = table.getn(bar.spellIds)  
  
  bar.buttonSize = E.db.betterTotemBar["buttonsize"]
  bar.countdownWidth = E.db.betterTotemBar["countdownwidth"]
  bar.showBackdrop = E.db.betterTotemBar["backdrop"]
  
  if bar.showBackdrop then
    bar.backdrop:Show()
  else
    bar.backdrop:Hide()
  end
  
  bar:SetFrameStrata("MEDIUM")
  bar:SetWidth((bar.numOfTotems*bar.buttonSize)+((bar.numOfTotems-1)*5)+4+bar.countdownWidth+8)
  bar:SetHeight(bar.buttonSize+4)
  bar:SetPoint("CENTER", x, y)
  
  bar.buttons = ElvBTBTotemBarButtons:createButtons(bar)
  bar.countdown = ElvBTBTotemBarCountdowns:createCountdown(bar)
  ElvBTBTotemBarMovers:createMover(bar)
  
  return bar
end

function ElvBTBTotemBars:updateBars(spellsChanged, optionsChanged)
  ElvBTBTotemBars.validTotems = ElvBTBTotem.validTotems()
  local numOfTotemsType = table.getn(ElvBTBTotemBars.validTotems)
  
  ElvBTBTotemBars.activeTotems = false
  
  for i=1,numOfTotemsType do
    ElvBTBTotemBars:updateBar(ElvBTBTotemBars[i], (spellsChanged and not UnitAffectingCombat("player")), optionsChanged)
    ElvBTBTotemBars.activeTotems = ElvBTBTotemBars.activeTotems or ElvBTBTotemBars[i].activeTotem
  end
end

function ElvBTBTotemBars:updateBar(bar, spellsChanged, optionsChanged)
  if optionsChanged then
    bar.buttonSize = E.db.betterTotemBar["buttonsize"]
    bar.countdownWidth = E.db.betterTotemBar["countdownwidth"]
    bar.showBackdrop = E.db.betterTotemBar["backdrop"]
    
    bar:SetHeight(bar.buttonSize+4)    
    if bar.showBackdrop then
      bar.backdrop:Show()
    else
      bar.backdrop:Hide()
    end
  end

  if spellsChanged then
    bar.spellIds = ElvBTBTotemBars.validTotems[bar.totemType]
    bar.numOfTotems = table.getn(bar.spellIds)
  end
  
  if spellsChanged or optionsChanged then
    bar:SetWidth((bar.numOfTotems*bar.buttonSize)+((bar.numOfTotems-1)*5)+4+bar.countdownWidth+8)
  
    ElvBTBTotemBarButtons:updateButtons(bar, bar.buttons, optionsChanged)
  end
  
  haveTotem, _, startTime, duration, _ = GetTotemInfo(bar.totemType)
  if startTime > 0 then
    ElvBTBTotemBarCountdowns:updateCountdown(bar.countdown, 1-((GetTime()-startTime)/duration), optionsChanged)
    bar.activeTotem = true
  else
    ElvBTBTotemBarCountdowns:updateCountdown(bar.countdown, 0, optionsChanged)
    bar.activeTotem = false
  end
end

_G["ElvBTBTotemBars"] = ElvBTBTotemBars
