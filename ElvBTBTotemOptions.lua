_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local E, L, DF, G = unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB

local ElvBTBTotem = nil
local ElvBTBTotemOptions = {}

function ElvBTBTotemOptions:createOptions()
  ElvBTBTotem = _G["ElvBTBTotem"]
  
  if not E.db.betterTotemBar then E:CopyTable(E.db.betterTotemBar, DF.betterTotemBar) end
  
  -- Register to receive profile changed callback
  E.data.RegisterCallback(ElvBTBTotemOptions, "OnProfileChanged", "updateAll") 
  
  E.Options.args.actionbar.args["betterTotemBar"] = {
    order = 201,
    name = "Better Totem Bar",
    type = 'group',
    guiInline = false,
    get = function(info) return E.db.betterTotemBar[ info[#info] ] end,
    set = function(info, value) E.db.betterTotemBar[ info[#info] ] = value; ElvBTBTotemOptions:updateAll() end,
    args = {
      enabled = {
        order = 1,
        type = 'toggle',
        name = L['Enable'],
        disabled = true
      },
      restorePosition = {
        order = 2,
        type = 'execute',
        name = L['Restore Bar'],
        desc = L['Restore the actionbars default settings'],
        func = function() E:CopyTable(E.db.betterTotemBar, DF.betterTotemBar); ElvBTBTotemOptions:updateAll() end
      },
      spacer = {
        order = 3,
        type = 'description',
        name = ""
      },
      backdrop = {
        order = 4,
        type = "toggle",
        name = L['Backdrop'],
        desc = L['Toggles the display of the actionbars backdrop.']
      },
      buttonsize = {
        order = 5,
        type = 'range',
        name = L['Button Size'],
        desc = L['The size of the action buttons.'],
        min = 15, max = 60, step = 1
      },
      countdownwidth = {
        order = 6,
        type = 'range',
        name = L['Countdown Width'],
        desc = L['The width of the countdown bar.'],
        min = 1, max = 15, step = 1
      },
      -- From here till I tell, is the part the needs to be removed for MoP version
      elements = {
        order = 7,
        type = 'group',
        name = "Call of the Elements",
        guiInline = true,
        get = function(info) return "foo" end,
        set = function(info, value) end,
        args = {
          fire = {
            order = 1,
            type = "select",
            name = "Fire Totem",
            values = {
              ["2894"] = "Fire Elemental Totem",
              ["3599"] = "Searing Totem",
              ["8190"] = "Magma Totem",
              ["8227"] = "Flametongue Totem"
            }
          },
          earth = {
            order = 2,
            type = "select",
            name = "Earth Totem",
            values = {
              ["2062"] = "Earth Elemental Totem",
              ["2484"] = "Earthbind Totem",
              ["5730"] = "Stoneclaw Totem",
              ["8071"] = "Stoneskin Totem",
              ["8075"] = "Strength of Earth Totem",
              ["8143"] = "Tremor Totem"
            }
          },
          water = {
            order = 3,
            type = "select",
            name = "Water Totem",
            values = {
              ["2062"] = "Earth Elemental Totem"
            }
          },
          air = {
            order = 4,
            type = "select",
            name = "Air Totem",
            values = {
              ["2062"] = "Earth Elemental Totem",
            }
          },
        }
      }
      -- Here, stop removing
    }
  }
end

function ElvBTBTotemOptions:updateAll()
  ElvBTBTotemBars:updateBars(false, true)
end

DF.betterTotemBar = {
  enabled = true,
  backdrop = false,
  buttonsize = 30,
  countdownwidth = 5
}

_G["ElvBTBTotemOptions"] = ElvBTBTotemOptions