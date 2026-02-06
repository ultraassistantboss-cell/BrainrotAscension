local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RebirthEvent = ReplicatedStorage:WaitForChild("RebirthEvent")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

RebirthEvent.OnServerEvent:Connect(function(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end
    
    local aura = leaderstats:FindFirstChild("Aura")
    local rebirths = leaderstats:FindFirstChild("Rebirths")
    local brainCells = leaderstats:FindFirstChild("Brain Cells")
    
    if aura and rebirths and brainCells and aura.Value >= MemeMeta.RebirthConfig.BaseRequirement then
        -- Reset stats
        aura.Value = 0
        brainCells.Value = 0
        
        -- Increment Rebirth
        rebirths.Value += 1
        
        print(player.Name .. " has REBIRTHED! Total Rebirths: " .. rebirths.Value)
        
        -- Optional: Visual effect or sound on rebirth can be triggered here
    end
end)
