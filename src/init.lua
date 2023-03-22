-- Module
local unsigned = {
    Obfuscate = {},
    Initialized = false
}

-- Imports
local Logger = require(script.UnsignedLogger)
local Obfuscator = require(script.Obfuscator)
local RunService = game:GetService("RunService")

-- Throw error if module is running on server.
if RunService:IsServer() then
    Logger:Error("Unsigned cannot run on the server.")
end

function unsigned:Init()
    Obfuscator:Init(self.Obfuscate)

    self.Obfuscate = {}
    self.Initialized = true
end

function unsigned:AddEvent(object: RemoteEvent)
    if self.Initialized then
        Logger:Error("Objects cannot be added after initialization.")
    end

    local event = {}

    function event:FireServer(...)
        object.Parent = game.ReplicatedStorage
        object:FireServer(...)
        object.Parent = nil
    end

    event.OnClientEvent = object.OnClientEvent

    table.insert(unsigned.Obfuscate, object)

    return event
end

function unsigned:AddFunction(object: RemoteFunction)
    if self.Initialized then
        Logger:Error("Objects cannot be added after initialization.")
    end
    
    local func = {}

    function func:InvokeServer(...)
        object.Parent = game.ReplicatedStorage
        object:InvokeServer(...)
        object.Parent = nil
    end

    table.insert(unsigned.Obfuscate, object)

    return func
end

return unsigned