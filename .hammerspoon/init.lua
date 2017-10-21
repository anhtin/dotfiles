-- Dependencies
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"

-- Modifier key
mod = {"cmd", "ctrl"}
Mod = {"cmd", "ctrl", "shift"}

-- Quick reload config
hs.alert.show("Hammerspoon config loaded")
hotkey.bind(mod, "r", function()
    if wifiWatcher then
        wifiWatcher:stop()
    end
    if batWatcher then
        batWatcher:stop()
    end
    if screenWatcher then
        screenWatcher:stop()
    end
    hs.reload()
end)

-- Speech Syntheziser
local speech = hs.speech.new(hs.speech.defaultVoice())

-- Network notification
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
    if currBatPercentage <= 20 and batPercentage > 20 then
        hs.alert.show("Low battery")
        if not speech:isSpeaking() then
            speech:speak("Low battery")
        end
    elseif currBatPercentage <= 10 and batPercentage > 10 then
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

        if powerSource == "AC Power" then
            toggleBluetooth(true)
        else
            toggleBluetooth(false)
        end
    end

    batPowerSource = powerSource
end
local batWatcher = hs.battery.watcher.new(batteryChanged)
batWatcher:start()

-- Screen changes
local function screenChanged()
    if batWatcher then
        batWatcher:stop()
        batWatcher:start()
    else
        hs.alert.show("Welcome back Tin!")
    end
end
local screenWatcher = hs.screen.watcher.new(screenChanged)
screenWatcher:start()

-- Specific application focus
local function openApplication(name)
    local app = hs.appfinder.appFromName(name)
    if app then
        app:activate()
    end
end

-- Keybindings
hotkey.bind(mod, "l", function() hs.caffeinate.systemSleep() end)
hotkey.bind(mod, "m", function() tiling.cycleLayout() end)
hotkey.bind(mod, "n", function() tiling.cycle(1) end)
hotkey.bind(Mod, "p", function() tiling.cycle(-1) end)
hotkey.bind(mod, "space", function() tiling.promote() end)
hotkey.bind(mod, "s", function() tiling.retile() end)
hotkey.bind(mod, "=", function() tiling.adjustMainVertical(0.1) end)
hotkey.bind(mod, "-", function() tiling.adjustMainVertical(-0.1) end)
hotkey.bind(mod, "0", function() tiling.setMainVertical(0.5) end)

hotkey.bind(mod, "i", function() openApplication("iTerm2") end)
hotkey.bind(mod, "b", function() openApplication("Google Chrome") end)
hotkey.bind(mod, "u", function() openApplication("Mail") end)
hotkey.bind(mod, "o", function() openApplication("Finder") end)
hotkey.bind(mod, "e", function() openApplication("Code") end)
hotkey.bind(mod, "p", function() openApplication("Preview") end)
hotkey.bind(mod, "v", function() openApplication("VirtualBox VM") end)
hotkey.bind(mod, "h", function() hs.hints.windowHints() end)
hotkey.bind(mod, "j", function() openApplication("Spotify") end)

hotkey.bind(mod, "t", function()
    hs.alert.show(os.date("%A, %B"), 3)
    hs.alert.show(os.date("%d/%m/%Y  %X"), 3)
    hs.alert.show(math.floor(batPercentage) .. " %", 3)
end)

-- Bluetooth handling
local isBluetoothOn = batPowerSource == "AC Power"
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
hotkey.bind(mod, "q", function() toggleBluetooth() end)

-- Enabled layouts
tiling.set('layouts', {'main-vertical-variable', 'fullscreen'})