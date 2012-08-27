_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local ElvBTBTotem = {}

ElvBTBTotem.FLYOUT_IDS = {
  80,  -- Fire Totems
  79,  -- Earth Totems
  82,  -- Water Totems
  81   -- Air Totems
}

ElvBTBTotem.TOTEM_COLORS = {
  {.58,.23,.10},  -- Fire Totems Color
  {.23,.45,.13},  -- Earth Totems Color
  {.19,.48,.60},  -- Water Totems Color
  {.42,.18,.74}   -- Air Totems Color
}

ElvBTBTotem.TOTEM_SCHOOL_NAMES = {
  "Fire",   -- Fire Totems School Name
  "Earth",  -- Earth Totems School Name
  "Water",  -- Water Totems School Name
  "Air"     -- Air Totems School Name
}

function ElvBTBTotem:validTotems()  -- Returns the current valid list of Totems
  local toReturn = {
    {},  -- Valid Fire Totems
    {},  -- Valid Earth Totems
    {},   -- Valid Water Totems
    {}   -- Valid Air Totems
  }
  
  for i = 1,4 do
    _, _, numSlots, isKnown = GetFlyoutInfo(ElvBTBTotem.FLYOUT_IDS[i])
    
    if isKnown then
      for slot = 1,numSlots do
        spellId, actionSpellId, spellIsKnown = GetFlyoutSlotInfo(ElvBTBTotem.FLYOUT_IDS[i], slot)
        
        if spellIsKnown then
          table.insert(toReturn[i], spellId)
        end
      end
    end
  end
  
  return toReturn
end

_G["ElvBTBTotem"] = ElvBTBTotem