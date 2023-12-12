local icon_cache = {}
local user = require("user")

local function Get_icon(client, program_string, class_string, is_steam)
    client = client or nil
    program_string = program_string or nil
    class_string = class_string or nil
    is_steam = is_steam or nil

    if (client or program_string or class_string) then
        local clientName
        if is_steam then
            clientName = "steam_icon_" .. tostring(client) .. ".png"
        elseif client then
            if client.class then
                clientName = string.lower(client.class:gsub(" ", "")) .. ".png"
            elseif client.name then
                clientName = string.lower(client.name:gsub(" ", "")) .. ".png"
            else
                if client.icon then
                    return client.icon
                else
                    return user.icon_theme .. "/128/apps/applications-other.png"
                end
            end
        else
            if program_string then
                clientName = program_string .. ".png"
            else
                clientName = class_string .. ".png"
            end
        end

        for index, icon in ipairs(icon_cache) do
            if icon:match(clientName) then return icon end
        end

        local iconDir = user.icon_theme .. "/128/apps/"
        local ioStream = io.open(iconDir .. clientName, "r")
        if ioStream ~= nil then
            icon_cache[#icon_cache + 1] = iconDir .. clientName
            return iconDir .. clientName
        else
            clientName = clientName:gsub("^%l", string.upper)
            iconDir = user.icon_theme .. "/128/apps/"
            ioStream = io.open(iconDir .. clientName, "r")
            if ioStream ~= nil then
                icon_cache[#icon_cache + 1] = iconDir .. clientName
                return iconDir .. clientName
            elseif not class_string then
                return user.icon_theme .. "/128/apps/applications-other.png"
            else
                clientName = class_string .. ".png"
                iconDir = user.icon_theme .. "128/apps/"
                ioStream = io.open(iconDir .. clientName, "r")
                if ioStream ~= nil then
                    icon_cache[#icon_cache + 1] = iconDir .. clientName
                    return iconDir .. clientName
                else
                    return user.icon_theme .. "/128/apps/applications-other.png"
                end
            end
        end
    end
    if client then
        return user.icon_theme .. "/128/apps/applications-other.png"
    end
end

return Get_icon
