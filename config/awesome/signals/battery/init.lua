local naughty = require("naughty")
local awful = require("awful")

local prevStatus = {
    charging = false,
    lowBattery = false,
    fullyCharged = false,
    discharging = false
}

local function checkBatteryStatus()
    awful.spawn.with_line_callback(
        "upower -i /org/freedesktop/UPower/devices/battery_BAT0", {
            stdout = function(line)
                if line:match("state:") then
                    local currentCharging = line:match("state:%s*charging")
                    local currentDischarging =
                        line:match("state:%s*discharging")
                    local currentFullyCharged = line:match(
                                                    "state:%s*pending%-charge")

                    if currentCharging then
                        if not prevStatus.charging then
                            naughty.notify({
                                title = "Battery plugged in!",
                                text = "The battery is now charging."
                            })
                        end
                        prevStatus.charging = true
                    else
                        prevStatus.charging = false
                    end

                    if currentFullyCharged then
                        if not prevStatus.fullyCharged then
                            naughty.notify({
                                title = "Battery capacity met!",
                                text = "The battery is now full."
                            })
                        end
                        prevStatus.fullyCharged = true
                    else
                        prevStatus.fullyCharged = false
                    end
                end

                if line:match("percentage:") then
                    local percentage = tonumber(line:match("(%d+)%%")) or 0
                    if percentage <= 15 then
                        if not prevStatus.lowBattery then
                            naughty.notify({
                                title = "Low battery!",
                                text = "Please plug in the device.",
                                timeout = 0
                            })
                        end
                        prevStatus.lowBattery = true
                    else
                        prevStatus.lowBattery = false
                    end
                end
            end,
            stderr = function(err)
                naughty.notify({
                    title = "An error occurred!",
                    text = "Error checking battery status: " .. err
                })
            end
        })
end

awful.widget.watch(
    "bash -c 'sleep 1 && upower -i /org/freedesktop/UPower/devices/battery_BAT0'",
    60, function(widget, stdout) checkBatteryStatus() end)
