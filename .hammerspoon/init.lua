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

-- Bluetooth handling
local isBluetoothOn = true
os.execute("/usr/local/bin/blueutil " .. (isBluetoothOn and "on" or "off"))
hs.alert.show("Bluetooth is " .. (isBluetoothOn and "enabled" or "disabled"))
function toggleBluetooth(on)
    if on == false or on == nil and isBluetoothOn then
        os.execute("/usr/local/bin/blueutil off")
        isBluetoothOn = false
        hs.alert.show("Bluetooth disabled")
    else
        os.execute("/usr/local/bin/blueutil on")
        isBluetoothOn = true
        hs.alert.show("Bluetooth enabled")
    end
end

-- Specific Application Focus
local function openApplication(name)
    local app = hs.appfinder.appFromName(name)
    if app then
        app:activate()
    end
end

-- Move Window Between Spaces
-- Adapted from: https://stackoverflow.com/questions/46818712/using-hammerspoon-and-the-spaces-module-to-move-window-to-new-space
function MoveWindowToSpace(space)
    local window = hs.window.focusedWindow()
    local screenId = window:screen():spacesUUID()
    local spaceId = spaces.layout()[screenId][space]
    spaces.moveWindowToSpace(window:id(), spaceId)
end

-- Keybindings
hotkey.bind(mod, "b", function() toggleBluetooth() end)
hotkey.bind(mod, "h", function() hs.hints.windowHints() end)
hotkey.bind(mod, "l", function() hs.caffeinate.systemSleep() end)
hotkey.bind(mod, "t", function()
    hs.alert.show(os.date("%A, %B"), 3)
    hs.alert.show(os.date("%d/%m/%Y  %X"), 3)
    hs.alert.show(math.floor(batPercentage) .. " %", 3)
end)
hs.hotkey.bind(Mod, '0', function() MoveWindowToSpace(1) end)
hs.hotkey.bind(Mod, '1', function() MoveWindowToSpace(2) end)
hs.hotkey.bind(Mod, '2', function() MoveWindowToSpace(3) end)
hs.hotkey.bind(Mod, '3', function() MoveWindowToSpace(4) end)
hs.hotkey.bind(Mod, '4', function() MoveWindowToSpace(5) end)
hs.hotkey.bind(Mod, '5', function() MoveWindowToSpace(6) end)
hs.hotkey.bind(Mod, '6', function() MoveWindowToSpace(7) end)
hs.hotkey.bind(Mod, '7', function() MoveWindowToSpace(8) end)
hs.hotkey.bind(Mod, '8', function() MoveWindowToSpace(9) end)
hs.hotkey.bind(Mod, '9', function() MoveWindowToSpace(10) end)

