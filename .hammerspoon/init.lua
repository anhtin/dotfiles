-- Dependencies
local hotkey = require "hs.hotkey"
local spaces = require("hs._asm.undocumented.spaces")

-- Modifier Key
Mod = {"alt", "shift"}
mod = {"cmd", "ctrl", "shift"}

-- Quick Reload Config
hs.alert.show("Hammerspoon config loaded")
hotkey.bind(mod, "r", function()
    if wifiWatcher then
        wifiWatcher:stop()
    end
    if batWatcher then
        batWatcher:stop()
    end
    hs.reload()
end)

-- Speech Syntheziser
local speech = hs.speech.new(hs.speech.defaultVoice())

-- Network Notification
local function networkChanged()
    ssid = hs.wifi.currentNetwork()
    if ssid == nil then
        hs.alert.show("Disconnected from network")
    else
        hs.alert.show("Connected to network")
        hs.alert.show(ssid)

        if ssid == "atin" then
            hs.execute("scselect Home")
        else
            hs.execute("scselect Automatic")
        end
    end
end
local wifiWatcher = hs.wifi.watcher.new(networkChanged)
wifiWatcher:start()

-- Battery notification
local batPercentage = hs.battery.percentage()
local batPowerSource = hs.battery.powerSource()
local function batteryChanged()
    local currBatPercentage = hs.battery.percentage()
    if currBatPercentage <= 10 and batPercentage > 10 then
        hs.alert.show("Low battery")
        if not speech:isSpeaking() then
            speech:speak("Low battery")
        end
    elseif currBatPercentage <= 5 and batPercentage > 5 then
        hs.alert.show("Critical low battery")
        if not speech:isSpeaking() then
            speech:speak("Critical low battery")
        end
    elseif currBatPercentage == 100 and batPercentage < 100 then
        hs.alert.show("Full battery")
        if not speech:isSpeaking() then
            speech:speak("Full battery")
        end
    end
    batPercentage = currBatPercentage

    local powerSource = hs.battery.powerSource()
    if powerSource ~= batPowerSource then
        hs.alert.show(powerSource)
    end

    batPowerSource = powerSource
end
local batWatcher = hs.battery.watcher.new(batteryChanged)
batWatcher:start()

-- Specific Application Focus
local function openApplication(name)
    local app = hs.appfinder.appFromName(name)
    if app then
        app:activate()
    end
end

-- Move Window Between Spaces
-- Adapted from: https://stackoverflow.com/questions/46818712/using-hammerspoon-and-the-spaces-module-to-move-window-to-new-space
function moveWindowToSpace(space)
    local window = hs.window.focusedWindow()
    local screenId = window:screen():spacesUUID()
    local spaceId = spaces.layout()[screenId][space]
    spaces.moveWindowToSpace(window:id(), spaceId)
end

-- Keybindings
hotkey.bind(mod, "return", function() openApplication("iTerm2") end)
hotkey.bind(mod, "h", function() hs.hints.windowHints() end)
hotkey.bind(mod, "l", function() hs.caffeinate.systemSleep() end)
hotkey.bind(mod, "t", function()
    hs.alert.show(os.date("%A, %B"), 3)
    hs.alert.show(os.date("%d/%m/%Y  %X"), 3)
    hs.alert.show(math.floor(batPercentage) .. " %", 3)
end)
hotkey.bind(Mod, "0", function() moveWindowToSpace(1) end)
hotkey.bind(Mod, "1", function() moveWindowToSpace(2) end)
hotkey.bind(Mod, "2", function() moveWindowToSpace(3) end)
hotkey.bind(Mod, "3", function() moveWindowToSpace(4) end)
hotkey.bind(Mod, "4", function() moveWindowToSpace(5) end)
hotkey.bind(Mod, "5", function() moveWindowToSpace(6) end)
hotkey.bind(Mod, "6", function() moveWindowToSpace(7) end)
hotkey.bind(Mod, "7", function() moveWindowToSpace(8) end)
hotkey.bind(Mod, "8", function() moveWindowToSpace(9) end)
hotkey.bind(Mod, "9", function() moveWindowToSpace(10) end)
