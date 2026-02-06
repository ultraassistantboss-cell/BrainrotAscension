local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClickEvent = ReplicatedStorage:WaitForChild("ClickEvent")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

ClickEvent.OnServerEvent:Connect(function(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local brainCells = leaderstats:FindFirstChild("Brain Cells")
        if brainCells then
            local multiplier = 1
            local inZone = player:FindFirstChild("InTaxZone")
            
            if inZone and inZone.Value == true then
                multiplier = MemeMeta.Zones.FanumTaxZone.Multiplier
            end
            
            brainCells.Value += multiplier
        end
    end
end)