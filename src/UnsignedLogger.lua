local logger = {}

function logger:Log(...: table)
    local message = ""

    if type(...) == "table" then
        for _, arg in pairs(...) do
            message = message..arg.." "
        end
    else
        message = ...
    end

    print(
        "Unsigned:",
        message
    )
end

function logger:Warn(...: table)
    local message = ""

    if type(...) == "table" then
        for _, arg in pairs(...) do
            message = message..arg.." "
        end
    else
        message = ...
    end

    warn(
        "Unsigned:",
        message
    )
end

function logger:Error(...)
    local message = ""

    if type(...) == "table" then
        for _, arg in pairs(...) do
            message = message..arg.." "
        end
    else
        message = ...
    end

    error("Unsigned: "..message)
end

return logger