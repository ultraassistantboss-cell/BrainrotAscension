local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

local function createPart(name, size, pos, color)
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.Position = pos
    p.Anchored = true
    p.Color = color
    p.Material = Enum.Material.Neon
    p.Parent = game.Workspace:WaitForChild("SigmaCity")
    return p
end

local function spawnTsunami()
    print("WARNING: BRAINROT TSUNAMI INCOMING!")
    
    local tsunami = createPart("Tsunami", Vector3.new(10, 50, 500), Vector3.new(-250, 25, 0), Color3.fromRGB(56, 189, 248))
    tsunami.Transparency = 0.3
    tsunami.CanCollide = false
    
    -- CaseOh Face (Placeholder Visual)
    local gui = Instance.new("BillboardGui")
    gui.Size = UDim2.new(0, 200, 0, 200)
    gui.AlwaysOnTop = true
    gui.Adornee = tsunami
    gui.Parent = tsunami
    
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, 0, 1, 0)
    img.BackgroundTransparency = 1
    img.Image = "rbxassetid://16262453535" -- Example CaseOh asset
    img.Parent = gui
    
    -- Movement Logic
    task.spawn(function()
        for i = 1, 500 do
            tsunami.Position = tsunami.Position + Vector3.new(1, 0, 0)
            
            -- Damage/Tax players on contact
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - tsunami.Position).Magnitude
                    if dist < 25 then
                        local ls = player:FindFirstChild("leaderstats")
                        if ls and ls:FindFirstChild("Brain Cells") then
                            ls["Brain Cells"].Value = math.max(0, ls["Brain Cells"].Value - 50)
                        end
                        -- Knockback
                        player.Character.HumanoidRootPart.Velocity = Vector3.new(100, 50, 0)
                    end
                end
            end
            task.wait(0.05)
        end
        tsunami:Destroy()
    end)
end

-- Trigger every 5 minutes for testing
while true do
    task.wait(300)
    spawnTsunami()
end
