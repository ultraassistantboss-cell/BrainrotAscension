local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

local zoneData = MemeMeta.Zones.FanumTaxZone

-- Create Fanum NPC
local fanum = Instance.new("Part")
fanum.Name = "FanumTheTaxMan"
fanum.Size = Vector3.new(4, 6, 2)
fanum.Position = zoneData.Position + Vector3.new(0, 5, 0)
fanum.Color = Color3.fromRGB(245, 158, 11)
fanum.Material = Enum.Material.Neon
fanum.Anchored = false
fanum.CanCollide = true
fanum.Parent = game.Workspace:WaitForChild("SigmaCity")

local humanoid = Instance.new("Humanoid")
humanoid.Parent = fanum

-- Visuals
local gui = Instance.new("BillboardGui")
gui.Size = UDim2.new(0, 100, 0, 50)
gui.AlwaysOnTop = true
gui.Adornee = fanum
gui.Parent = fanum

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 1, 0)
text.Text = "FANUM"
text.TextColor3 = Color3.new(1, 0, 0)
text.Font = Enum.Font.GothamBold
text.TextSize = 20
text.BackgroundTransparency = 1
text.Parent = gui

-- Patrol/Tax Logic
fanum.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats then
            local brainCells = leaderstats:FindFirstChild("Brain Cells")
            if brainCells and brainCells.Value > 0 then
                local taxAmount = math.floor(brainCells.Value * zoneData.TaxRate)
                brainCells.Value -= taxAmount
                print(player.Name .. " was FANUM TAXED for " .. taxAmount .. " Braincells!")
                
                -- Knockback effect
                local root = hit.Parent:FindFirstChild("HumanoidRootPart")
                if root then
                    local direction = (root.Position - fanum.Position).Unit
                    root.Velocity = direction * 50
                end
            end
        end
    end
end)

-- Basic AI: Chase nearest player in zone
task.spawn(function()
    while task.wait(0.5) do
        local players = game.Players:GetPlayers()
        local target = nil
        local minDist = 100

        for _, p in pairs(players) do
            local inZone = p:FindFirstChild("InTaxZone")
            if inZone and inZone.Value == true and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (fanum.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = p.Character.HumanoidRootPart
                end
            end
        end

        if target then
            humanoid:MoveTo(target.Position)
        else
            -- Move back to center of zone
            humanoid:MoveTo(zoneData.Position)
        end
    end
end)
