local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local brainCells = Instance.new("NumberValue")
    brainCells.Name = "Brain Cells"
    brainCells.Value = 0
    brainCells.Parent = leaderstats

    local auraPoints = Instance.new("NumberValue")
    auraPoints.Name = "Aura"
    auraPoints.Value = 0
    auraPoints.Parent = leaderstats

    local sigmaRank = Instance.new("StringValue")
    sigmaRank.Name = "Sigma Level"
    sigmaRank.Value = MemeMeta.SigmaRanks[1].Name
    sigmaRank.Parent = leaderstats

    -- Auto-Rank Logic based on Aura
    auraPoints.Changed:Connect(function(val)
        local currentRank = MemeMeta.SigmaRanks[1].Name
        for _, rank in ipairs(MemeMeta.SigmaRanks) do
            if val >= rank.Requirement then
                currentRank = rank.Name
            end
        end
        sigmaRank.Value = currentRank
    end)
end)