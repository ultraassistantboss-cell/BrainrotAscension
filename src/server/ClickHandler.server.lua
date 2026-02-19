local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClickEvent = ReplicatedStorage:WaitForChild("ClickEvent")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

ClickEvent.OnServerEvent:Connect(function(player)
    print("B.O.S.S.: Click received from " .. player.Name)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local brainCells = leaderstats:FindFirstChild("Brain Cells")
        if brainCells then
            local multiplier = 1
            local rebirths = leaderstats:FindFirstChild("Rebirths")
            if rebirths then
                multiplier = 1 + (rebirths.Value * MemeMeta.RebirthConfig.MultiplierPerRebirth)
            end

            local inZone = player:FindFirstChild("InTaxZone")
            
            if inZone and inZone.Value == true then
                multiplier = MemeMeta.Zones.FanumTaxZone.Multiplier
            end
            
            brainCells.Value += multiplier
            
            -- Also add to Aura (slowly)
            local aura = leaderstats:FindFirstChild("Aura")
            if aura then
                aura.Value += 1
            end
        end
    end
end)