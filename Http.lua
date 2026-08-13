--## SERVICES ##--
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

--## OTHERS ##--
local PlaceId = game.PlaceId
local LocalPlayer = Players.LocalPlayer

--## SCRIPT ##--
local module = {}

function module:Execute(url, GameName)
    local data = {
        ["embeds"] = {{
            ["fields"] = {
                { ["name"] = "Name", ["value"] = LocalPlayer.Name, ["inline"] = true },
                { ["name"] = "Display Name", ["value"] = LocalPlayer.DisplayName, ["inline"] = true },
                { ["name"] = "User Id", ["value"] = LocalPlayer.UserId, ["inline"] = true },
                { ["name"] = "Game", ["value"] = GameName, ["inline"] = true },
                { ["name"] = "Game Id", ["value"] = PlaceId, ["inline"] = true },
                { ["name"] = "Executor", ["value"] = tostring(identifyexecutor()), ["inline"] = true },
            },
            ["color"] = 16766181,
            ["thumbnail"] = { ["url"] = "https://media.discordapp.net/attachments/1470161236388741377/1537587220502814770/both_upscaled_2.png?ex=6a7f9530&is=6a7e43b0&hm=59ea769e0e1e232dbb53ca82e9c577938c8034b373d6ae8b8900e543752d0dc3&quality=lossless" },
            ["footer"] = {
                ["text"] = "Made by script",
                ["icon_url"] = "https://media.discordapp.net/attachments/1470161236388741377/1537587221274697748/match_1_2_1.jpg?ex=6a7f9530&is=6a7e43b0&hm=4ff2d48383ad5877c2bf9b9803095a3c31cbbe78416bc7205be75219c7e95cfa&=&width=1280&height=1280"
            }
        }}
    }
    http_request({ Url = tostring(url), Method = "POST", Headers = { ["Content-Type"] =  "application/json" }, Body = HttpService:JSONEncode(data) })
end

return module
