_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local LibActionButton = LibStub("LibActionButton-1.0")

local ElvBTBTotemBarButtons = {}

function ElvBTBTotemBarButtons:createButtons(bar)
  buttons = {}
  for i=1,7 do
    buttons[i] = ElvBTBTotemBarButtons:createButton(bar, bar.spellIds[i], i)
  end
  
  return buttons
end

function ElvBTBTotemBarButtons:createButton(bar, spellId, position)
  button = LibActionButton:CreateButton(10*bar.totemType+position, format(bar:GetName().."Button%d", position), bar)
  button.bar = bar
  
  button:Size(bar.buttonSize)
  button:Point("BOTTOMLEFT", (position-1)*(bar.buttonSize+5)+2+bar.countdownWidth+8, 2)
  button:DisableDragNDrop(true)
  
  button:SetTemplate("Default")
  button:StyleButton()
  local icon = select(1,button:GetRegions())
  icon:SetTexCoord(.09,.91,.09,.91)
  icon:SetDrawLayer("ARTWORK")
  icon:Point("TOPLEFT",button,"TOPLEFT",2,-2)
  icon:Point("BOTTOMRIGHT",button,"BOTTOMRIGHT",-2,2)
  
  ElvBTBTotemBarButtons:updateButton(button, spellId)
  
  return button
end

function ElvBTBTotemBarButtons:updateButtons(bar, buttons, optionsChanged)
  for i=1,7 do
    ElvBTBTotemBarButtons:updateButton(buttons[i], bar.spellIds[i], i, optionsChanged)
  end
end

function ElvBTBTotemBarButtons:updateButton(button, spellId, position, optionsChanged)
  if optionsChanged then
    button:Size(button.bar.buttonSize)
    button:Point("BOTTOMLEFT", (position-1)*(button.bar.buttonSize+5)+2+button.bar.countdownWidth+8, 2)
  end

  if spellId then
    button:SetState(0, "spell", spellId)
    button:Show()
  else
    button:SetState(0, "empty", nil)
    button:Hide()
  end
end

_G["ElvBTBTotemBarButtons"] = ElvBTBTotemBarButtons