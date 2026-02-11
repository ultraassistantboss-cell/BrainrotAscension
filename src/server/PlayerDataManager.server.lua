local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("SigmaPlayerData_v2")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

local function createLeaderstats(player)
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

    local rebirths = Instance.new("NumberValue")
    rebirths.Name = "Rebirths"
    rebirths.Value = 0
    rebirths.Parent = leaderstats

    -- Auto-Rank Logic
    auraPoints.Changed:Connect(function(val)
        local currentRank = MemeMeta.SigmaRanks[1].Name
        for _, rank in ipairs(MemeMeta.SigmaRanks) do
            if val >= rank.Requirement then
                currentRank = rank.Name
            end
        end
        sigmaRank.Value = currentRank
    end)

    return leaderstats
end

local function savePlayerData(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local data = {
            BrainCells = leaderstats["Brain Cells"].Value,
            Aura = leaderstats["Aura"].Value,
            Rebirths = leaderstats["Rebirths"].Value
        }
        pcall(function()
            PlayerDataStore:SetAsync(tostring(player.UserId), data)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    local leaderstats = createLeaderstats(player)
    
    local success, data = pcall(function()
        return PlayerDataStore:GetAsync(tostring(player.UserId))
    end)

    if success and data then
        leaderstats["Brain Cells"].Value = data.BrainCells or 0
        leaderstats["Aura"].Value = data.Aura or 0
        leaderstats["Rebirths"].Value = data.Rebirths or 0
    end
end)

Players.PlayerRemoving:Connect(savePlayerData)

game:BindToClose(function()
    for _, player in pairs(Players:GetPlayers()) do
        savePlayerData(player)
    end
end)

-- Auto-save
task.spawn(function()
    while true do
        task.wait(60) -- Save every minute for extra safety
        for _, player in pairs(Players:GetPlayers()) do
            savePlayerData(player)
        end
    end
end)
