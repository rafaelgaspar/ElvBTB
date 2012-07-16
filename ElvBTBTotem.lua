_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local ElvBTBTotem = {}

ElvBTBTotem.TOTEM_SPELL_IDS = {
  {
    2894,    -- Fire Elemental Totem
    3599,    -- Searing Totem
    8190     -- Magma Totem
  },  -- Fire Totems
  {
    2062,    -- Earth Elemental Totem
    2484,    -- Earthbind Totem
    8143,    -- Tremor Totem
    51485,   -- Earthgrab Totem
    108270   -- Stone Bulwark Totem
  },  -- Earth Totems
  {
    5394,    -- Healing Stream Totem
    108280,  -- Healing Tide Totem
    16190    -- Mana Tide Totem
  },  -- Water Totems
  {
    108269,  -- Capacitor Totem
    8177,    -- Grounding Totem
    120668,  -- Stormlash Totem
    108273,  -- Windwalk Totem
    98008    -- Spirit Link Totem
  }   -- Air Totems
}

ElvBTBTotem.TOTEM_COLORS = {
  {.58,.23,.10},  -- Fire Totems
  {.23,.45,.13},  -- Earth Totems
  {.19,.48,.60},  -- Water Totems
  {.42,.18,.74}   -- Air Totems
}

ElvBTBTotem.TOTEM_SCHOOL_NAMES = {
  "Fire",   -- Fire Totems
  "Earth",  -- Earth Totems
  "Water",  -- Water Totems
  "Air"     -- Air Totems
}

function ElvBTBTotem:validTotems()  -- Returns the current valid list of Totems
  local toReturn = {
    {},  -- Valid Fire Totems
    {},  -- Valid Earth Totems
    {},  -- Valid Fire Totems
    {}   -- Valid Air Totems
  }
  
  local i = 1
  local spellName, _ = GetSpellBookItemName(i, BOOKTYPE_SPELL)
  while spellName do
    _, spellId = GetSpellBookItemInfo(spellName)
  
    for j = 1,4 do
      for k = 1,table.getn(ElvBTBTotem.TOTEM_SPELL_IDS[j]) do
        if spellId == ElvBTBTotem.TOTEM_SPELL_IDS[j][k] then
           -- Found a Totem, time to store it
           table.insert(toReturn[j], spellId)
        end
      end
    end
    
    i = i + 1
    spellName, _ = GetSpellBookItemName(i, BOOKTYPE_SPELL)
  end
  
  return toReturn
end

_G["ElvBTBTotem"] = ElvBTBTotem