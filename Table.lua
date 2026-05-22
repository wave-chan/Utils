--## SERVICES ##--
local Players = game:GetService("Players")

--## SCRIPT ##--
local module = {}

function module:Size(Table)
    local Size = 0
    for _, _ in Table do
        Size += 1
    end
    return Size
end

return module
