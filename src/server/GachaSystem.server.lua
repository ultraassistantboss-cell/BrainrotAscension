local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GachaSpin = ReplicatedStorage:WaitForChild("GachaSpin")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

local SPIN_COST = 10

local function getRandomAura()
    local roll = math.random() * 100
    local currentWeight = 0
    
    for _, aura in ipairs(MemeMeta.Auras) do
        currentWeight += aura.Rarity
        if roll <= currentWeight then
            return aura
        end
    end
    return MemeMeta.Auras[1]
end

GachaSpin.OnServerEvent:Connect(function(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end
    
    local brainCells = leaderstats:FindFirstChild("Brain Cells")
    local auraPoints = leaderstats:FindFirstChild("Aura")
    
    if brainCells and brainCells.Value >= SPIN_COST then
        brainCells.Value -= SPIN_COST
        
        local aura = getRandomAura()
        print(player.Name .. " rolled: " .. aura.Name)
        
        -- Gain 'Aura' points based on the multiplier of the roll
        -- Aura points are the 'XP' that increases Sigma Rank
        auraPoints.Value += (10 * aura.Multiplier)
        
        GachaSpin:FireClient(player, aura)
    else
        -- Logic for "Not enough Brain Cells" can be added here
    end
end)