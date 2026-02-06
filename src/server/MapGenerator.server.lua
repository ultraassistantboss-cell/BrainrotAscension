local Map = Instance.new("Folder")
Map.Name = "SigmaCity"
Map.Parent = game.Workspace

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
    p.Parent = Map
    return p
end

-- Ground
createPart("Floor", Vector3.new(500, 1, 500), Vector3.new(0, -0.5, 0), Color3.fromRGB(15, 23, 42))

-- Fanum Tax Zone
local zoneData = MemeMeta.Zones.FanumTaxZone
local taxZone = createPart("FanumTaxZone", zoneData.Size, zoneData.Position, Color3.fromRGB(239, 68, 68))
taxZone.Transparency = 0.5
taxZone.CanCollide = false

local zoneLabel = Instance.new("BillboardGui")
zoneLabel.Size = UDim2.new(0, 200, 0, 50)
zoneLabel.AlwaysOnTop = true
zoneLabel.Adornee = taxZone
zoneLabel.Parent = taxZone

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "FANUM TAX ZONE (5x BRAINCELLS)"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 14
label.Parent = zoneLabel

-- Track players in zone
taxZone.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local inZone = player:FindFirstChild("InTaxZone") or Instance.new("BoolValue", player)
        inZone.Name = "InTaxZone"
        inZone.Value = true
    end
end)

taxZone.TouchEnded:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local inZone = player:FindFirstChild("InTaxZone")
        if inZone then inZone.Value = false end
    end
end)

-- Shop Area
local shopBase = createPart("GachaShop_Base", Vector3.new(40, 20, 40), Vector3.new(60, 10, 60), Color3.fromRGB(56, 189, 248))
createPart("GachaShop_Sign", Vector3.new(30, 5, 2), Vector3.new(60, 25, 42), Color3.fromRGB(245, 158, 11))

-- Proximity Prompt for Shop
local prompt = Instance.new("ProximityPrompt")
prompt.ActionText = "Open Sigma Shop"
prompt.ObjectText = "Gacha Machine"
prompt.HoldDuration = 0.5
prompt.Parent = shopBase

prompt.Triggered:Connect(function(player)
    local openTag = Instance.new("StringValue")
    openTag.Name = "OpenShop"
    openTag.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
end)

-- Skyscrapers
for i = 1, 5 do
    local x = math.random(-200, 200)
    local z = math.random(-200, 200)
    local h = math.random(50, 150)
    createPart("SigmaTower", Vector3.new(30, h, 30), Vector3.new(x, h/2, z), Color3.fromRGB(30, 41, 59))
end

print("B.O.S.S. Map Generation: Sigma City v1.0 Loaded.")