_, myClassName = UnitClass("player")
if myClassName ~= "SHAMAN" then return end

local E, L, V, DF, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

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
        name = "Countdown Width", -- TODO Localize
        desc = "The width of the countdown bar.", -- TODO Localize
        min = 1, max = 15, step = 1
      }
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