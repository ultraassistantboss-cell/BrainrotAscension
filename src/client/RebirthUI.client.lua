local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Create Rebirth UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RebirthGui"
screenGui.Parent = pgui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.8, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
frame.BackgroundTransparency = 0.2
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "REBIRTH FOR 2x MULTIPLIER"
title.TextColor3 = Color3.fromRGB(245, 158, 11)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0.3, 0)
status.Text = "Requirement: 1,000,000 Aura"
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.BackgroundTransparency = 1
status.Parent = frame

local rebirthBtn = Instance.new("TextButton")
rebirthBtn.Size = UDim2.new(0.8, 0, 0, 50)
rebirthBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
rebirthBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
rebirthBtn.Text = "REBIRTH NOW"
rebirthBtn.Font = Enum.Font.GothamBold
rebirthBtn.TextColor3 = Color3.new(1, 1, 1)
rebirthBtn.TextSize = 20
rebirthBtn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.Parent = rebirthBtn

-- Logic
local function updateUI()
    local aura = player:WaitForChild("leaderstats"):WaitForChild("Aura").Value
    if aura >= MemeMeta.RebirthConfig.BaseRequirement then
        rebirthBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        rebirthBtn.Interactable = true
    else
        rebirthBtn.BackgroundColor3 = Color3.fromRGB(100, 116, 139)
        rebirthBtn.Interactable = false
    end
end

player:WaitForChild("leaderstats"):WaitForChild("Aura").Changed:Connect(updateUI)
updateUI()

-- Remote event for rebirth
local RebirthEvent = Instance.new("RemoteEvent")
RebirthEvent.Name = "RebirthEvent"
RebirthEvent.Parent = ReplicatedStorage

rebirthBtn.MouseButton1Click:Connect(function()
    RebirthEvent:FireServer()
end)
