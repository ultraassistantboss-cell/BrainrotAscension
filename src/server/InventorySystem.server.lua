local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

-- Limited Units Storage (Server Side)
local LimitedUnits = {
    ["Golden Strawberry Elephant"] = {Remaining = 500, Total = 500},
    ["OG Meowl"] = {Remaining = 1000, Total = 1000}
}

-- Create Inventory Folder for each player
Players.PlayerAdded:Connect(function(player)
    local inventory = Instance.new("Folder")
    inventory.Name = "Inventory"
    inventory.Parent = player
end)

-- Function to award a unit
local function awardUnit(player, unitName)
    local inv = player:FindFirstChild("Inventory")
    if inv then
        local unit = inv:FindFirstChild(unitName) or Instance.new("NumberValue")
        unit.Name = unitName
        unit.Value = unit.Value + 1
        unit.Parent = inv
        print("Awarded " .. unitName .. " to " .. player.Name)
    end
end

-- Update Gacha to include Limited Drops
local GachaSpin = ReplicatedStorage:WaitForChild("GachaSpin")
GachaSpin.OnServerEvent:Connect(function(player)
    -- This is a secondary listener to the main Gacha logic
    -- In a real game, you'd combine these, but for Rojo modularity we can separate.
    
    local roll = math.random()
    if roll <= 0.0001 then -- Ultra Rare "Whale" drop
        for name, data in pairs(LimitedUnits) do
            if data.Remaining > 0 then
                data.Remaining -= 1
                awardUnit(player, name)
                print("!!! GLOBAL DROP: " .. player.Name .. " found a " .. name .. " !!!")
                break
            end
        end
    end
end)
