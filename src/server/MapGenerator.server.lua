-- Clear default Baseplate
local baseplate = game.Workspace:FindFirstChild("Baseplate")
if baseplate then
    baseplate:Destroy()
end

local Map = game.Workspace:FindFirstChild("SigmaCity") or Instance.new("Folder")
Map.Name = "SigmaCity"
Map.Parent = game.Workspace

-- Clear old procedural trash
for _, child in pairs(Map:GetChildren()) do
    if child:IsA("BasePart") and child.Name ~= "MainFloor" then
        child:Destroy()
    end
end

-- Create a STABLE floor
local floor = Map:FindFirstChild("MainFloor") or Instance.new("Part")
floor.Name = "MainFloor"
floor.Size = Vector3.new(1000, 1, 1000)
floor.Position = Vector3.new(0, -0.5, 0)
floor.Anchored = true
floor.Color = Color3.fromRGB(30, 41, 59)
floor.Material = Enum.Material.Concrete
floor.Parent = Map

-- Professional Asset Loader
local function spawnAsset(meshId, pos, size, name, color)
    local part = Instance.new("MeshPart")
    part.Name = name or "CityAsset"
    part.MeshId = meshId
    part.Position = pos
    part.Size = size or Vector3.new(10, 10, 10)
    part.Anchored = true
    if color then part.Color = color end
    part.Parent = Map
    return part
end

-- Sigma Skyscrapers (Using optimized building Mesh)
local skyscraperMesh = "rbxassetid://430310210" 
local shopMesh = "rbxassetid://430310210"
local treeMesh = "rbxassetid://1354316686"

-- Spawn a circular city layout
for i = 1, 10 do
    local angle = (i / 10) * math.pi * 2
    local x = math.cos(angle) * 200
    local z = math.sin(angle) * 200
    local height = 80 + math.random(20, 60)
    spawnAsset(skyscraperMesh, Vector3.new(x, height/2, z), Vector3.new(40, height, 40), "SigmaTower_" .. i, Color3.fromRGB(40, 44, 52))
end

-- Decorative Trees
for i = 1, 20 do
    local x = math.random(-300, 300)
    local z = math.random(-300, 300)
    if (Vector3.new(x, 0, z) - Vector3.new(0,0,0)).Magnitude > 60 then
        spawnAsset(treeMesh, Vector3.new(x, 4, z), Vector3.new(8, 16, 8), "BrainrotTree", Color3.fromRGB(34, 139, 34))
    end
end

-- Functional Gacha Shop
local shop = spawnAsset(shopMesh, Vector3.new(80, 10, 80), Vector3.new(30, 20, 30), "GachaShop", Color3.fromRGB(56, 189, 248))

-- Proximity Prompt for Shop
local prompt = Instance.new("ProximityPrompt")
prompt.ActionText = "Open Sigma Shop"
prompt.ObjectText = "Gacha Machine"
prompt.HoldDuration = 0.5
prompt.Parent = shop

prompt.Triggered:Connect(function(player)
    local openTag = Instance.new("StringValue")
    openTag.Name = "OpenShop"
    openTag.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
end)

print("B.O.S.S. System: Sigma City v2.6 Mesh Overhaul Live.")
