--## SERVICES ##--
local Players = game:GetService("Players")

--## SCRIPT ##--
local module = {}

function module:Get(plrName)
    local plr = plrName and Players:FindFirstChild(plrName) or Players.LocalPlayer
    local Chr = plr.Character or plr.CharacterAdded:Wait()
    if not Chr then return end

    local HRP = Chr:FindFirstChild("HumanoidRootPart")
    local Humanoid = Chr:FindFirstChild("Humanoid")
    if not HRP or not Humanoid then return end

    return Chr, HRP, Humanoid
end

function module:GetMagnitudeFromCharacter(Part)
    local Character = module:Get()
    if not Character then return end

    Character = Character:GetPivot().Position

    if typeof(Part) == "CFrame" then
        return (Character-Part.Position).Magnitude
    elseif typeof(Part) == "Vector3" then
        return (Character-Part).Magnitude
    end

    if Part:IsA("Model") then
        return (Character-Part:GetPivot().Position).Magnitude
    elseif Part:IsA("BasePart") then
        return (Character-Part.Position).Magnitude
    end
    return nil
end

return module
