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

function module:LoadFolder(Folder, Data, IgnoreTable: {})
    IgnoreTable = IgnoreTable or {}

    for _, Child in ipairs(Folder:GetChildren()) do
        if table.find(IgnoreTable, Child) then continue end

        if Child:IsA("Folder") then
            Data[Child.Name] = Data[Child.Name] or {}
            self:LoadFolder(Child, Data[Child.Name], IgnoreTable)
        elseif Child:IsA("ValueBase") then
            Data[Child.Name] = Child.Value
        end
    end
end

return module
