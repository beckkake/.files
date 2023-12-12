local lfs = require("lfs")
local naughty = require("naughty")

local directory_path = "/home/beck/Pictures/Wallpapers/"
local target_file_path = "/home/beck/.config/awesome/user.lua"
local variable_to_replace = "user.wallpaper"

local function getFilesInDirectory(directory)
    local files = {}
    for file in lfs.dir(directory) do
        if file ~= "." and file ~= ".." then
            if file:match("%.jpg$") or file:match("%.jpeg$") or
                file:match("%.png$") or file:match("%.gif$") or
                file:match("%.bmp$") then table.insert(files, file) end
        end
    end
    return files
end

local function selectRandomImage(files)
    if #files == 0 then
        return nil
    else
        local randomIndex = math.random(#files)
        return files[randomIndex]
    end
end

local function replaceVariableWithImage(fileName)
    local file_content = io.open(target_file_path, "r")
    if not file_content then
        naughty.notiy({
            title = "Failure!",
            text = "Failed to open the target file"
        })
    end

    local content = file_content:read("*all")
    file_content:close()

    local updated_content = content:gsub(
                                variable_to_replace .. " = wallpapers .. \".-\"",
                                variable_to_replace .. " = wallpapers .. \"" ..
                                    fileName .. "\"")

    local file_write = io.open(target_file_path, "w")
    if not file_write then
        naughty.notify({
            title = "Failure!",
            text = "Failed to write to the target file"
        })
    end

    file_write:write(updated_content)
    file_write:close()

    naughty.notify({
        title = "Success!",
        text = "Replaced your current wallpaper with " .. fileName
    })
end

local imageFiles = getFilesInDirectory(directory_path)

local randomImage = selectRandomImage(imageFiles)

if randomImage then
    replaceVariableWithImage(randomImage)
else
    naughty.notify({
        title = "Failure!",
        text = "No images were found in the given directory"
    })
end
