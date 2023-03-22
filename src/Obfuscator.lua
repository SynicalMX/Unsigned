-- Create module
local obfuscator = {}

-- Imports
local RunService = game:GetService("RunService")

-- Internal variables
local WAITING = false

-- Interal functions
local function generateName()
    local name = ""
    
    for i = 1, 5 do
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"
        local rint = math.random(1, #chars)
        local char = chars:sub(rint, rint)

        name = name..char
    end

    return name
end

-- Module functions
function obfuscator:Init(objects)
    for _, object in pairs(objects) do
        object.Name = generateName()
        object.Parent = nil

        RunService.Heartbeat:Connect(function()
            if WAITING then return end
            WAITING = true

            object.Name = generateName()

            task.wait(0.2)
            WAITING = false
        end)
    end
end

return obfuscator
