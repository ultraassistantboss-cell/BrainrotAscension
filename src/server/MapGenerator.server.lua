-- BOSS CITY BUILDER v3.0 - LOCKING IN
print("B.O.S.S.: Initializing City Build...")

-- Clear default Baseplate
local baseplate = game.Workspace:FindFirstChild("Baseplate")
if baseplate then
    baseplate:Destroy()
    print("B.O.S.S.: Baseplate Destroyed.")
end

local Map = game.Workspace:FindFirstChild("SigmaCity") or Instance.new("Folder")
Map.Name = "SigmaCity"
Map.Parent = game.Workspace

-- Clear old procedural trash
for _, child in pairs(Map:GetChildren()) do
    child:Destroy()
end

-- Create a STABLE floor
local floor = Instance.new("Part")
floor.Name = "MainFloor"
floor.Size = Vector3.new(2000, 1, 2000)
floor.Position = Vector3.new(0, -0.5, 0)
floor.Anchored = true
floor.Color = Color3.fromRGB(15, 23, 42)
floor.Material = Enum.Material.Concrete
floor.Parent = Map

-- Asset Spawner (Part-based Buildings with Windows)
local function spawnBuilding(pos, size, color)
    local b = Instance.new("Part")
    b.Name = "Skyscraper"
    b.Size = size
    b.Position = pos
    b.Anchored = true
    b.Material = Enum.Material.Glass
    b.Color = color or Color3.fromRGB(30, 41, 59)
    b.Parent = Map
    
    -- Add some "windows" (Neon strips)
    for i = 1, 5 do
        local win = Instance.new("Part")
        win.Name = "WindowStrip"
        win.Size = Vector3.new(size.X + 0.5, 2, size.Z + 0.5)
        win.Position = pos + Vector3.new(0, (i * (size.Y/6)) - (size.Y/2), 0)
        win.Anchored = true
        win.CanCollide = false
        win.Material = Enum.Material.Neon
        win.Color = Color3.fromRGB(255, 255, 255)
        win.Transparency = 0.5
        win.Parent = b
    end
end

-- Massive Brainrot Meta Pack ID
local BrainrotAssets = {
    "72466520546640", -- User provided pack
    "16277815615",    -- Skibidi Toilet
    "16401666491",    -- Grimace Shake
}

local function spawnBrainrot(pos)
    local assetId = BrainrotAssets[math.random(#BrainrotAssets)]
    local success, model = pcall(function()
        return game:GetService("InsertService"):LoadAsset(tonumber(assetId))
    end)
    
    if success and model then
        model.Parent = Map
        -- Models from LoadAsset are usually nested
        local actualModel = model:GetChildren()[1]
        if actualModel then
            actualModel.Parent = Map
            if actualModel:IsA("Model") then
                actualModel:SetPrimaryPartCFrame(CFrame.new(pos + Vector3.new(0, 5, 0)))
            elseif actualModel:IsA("BasePart") then
                actualModel.Position = pos + Vector3.new(0, 5, 0)
                actualModel.Anchored = true
            end
        end
        model:Destroy()
        print("B.O.S.S.: Deployed Brainrot Asset " .. assetId)
    else
        -- Fallback: Giant Rainbow Block
        local fallback = Instance.new("Part")
        fallback.Size = Vector3.new(10, 20, 10)
        fallback.Position = pos + Vector3.new(0, 10, 0)
        fallback.Anchored = true
        fallback.Color = Color3.fromHSV(math.random(), 1, 1)
        fallback.Material = Enum.Material.Neon
        fallback.Parent = Map
        print("B.O.S.S.: Asset load failed for " .. assetId .. ", using fallback.")
    end
end

for x = -800, 800, 200 do
    for z = -800, 800, 200 do
        if math.random() > 0.2 then
            local pos = Vector3.new(x + 50, 0, z + 50)
            spawnBrainrot(pos)
            
            local height = 200 + math.random(100, 400)
            local color = Color3.fromHSV(math.random(), 0.7, 0.5)
            spawnBuilding(Vector3.new(x, height/2, z), Vector3.new(80, height, 80), color)
        end
    end
end

-- Add High-Speed Roads
local function spawnRoad(pos, size)
    local r = Instance.new("Part")
    r.Name = "AsphaltRoad"
    r.Size = size
    r.Position = pos
    r.Anchored = true
    r.Color = Color3.fromRGB(20, 20, 20)
    r.Material = Enum.Material.Asphalt
    r.Parent = Map
    
    -- Yellow line
    local line = Instance.new("Part")
    line.Size = (size.X > size.Z) and Vector3.new(size.X, 0.1, 1) or Vector3.new(1, 0.1, size.Z)
    line.Position = pos + Vector3.new(0, 0.1, 0)
    line.Anchored = true
    line.CanCollide = false
    line.Color = Color3.fromRGB(255, 255, 0)
    line.Material = Enum.Material.Neon
    line.Parent = r
end

for x = -900, 900, 200 do
    spawnRoad(Vector3.new(x, 0.2, 0), Vector3.new(40, 0.2, 2000))
end
for z = -900, 900, 200 do
    spawnRoad(Vector3.new(0, 0.2, z), Vector3.new(2000, 0.2, 40))
end

print("B.O.S.S.: City v3.0 Build Complete. The Skyline is LIVE.")
