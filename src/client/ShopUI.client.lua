local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GachaSpin = ReplicatedStorage:WaitForChild("GachaSpin")

local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Create Shop UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopGui"
screenGui.Enabled = false
screenGui.Parent = pgui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "SIGMA GACHA SHOP"
title.TextColor3 = Color3.fromRGB(56, 189, 248)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.BackgroundTransparency = 1
title.Parent = frame

local spinButton = Instance.new("TextButton")
spinButton.Size = UDim2.new(0.8, 0, 0, 60)
spinButton.Position = UDim2.new(0.1, 0, 0.7, 0)
spinButton.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
spinButton.Text = "SPIN (10 BRAIN CELLS)"
spinButton.Font = Enum.Font.GothamBold
spinButton.TextColor3 = Color3.new(1, 1, 1)
spinButton.TextSize = 18
spinButton.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 0, 0)
closeButton.Parent = frame

spinButton.MouseButton1Click:Connect(function()
    GachaSpin:FireServer()
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- Listener for opening shop
ReplicatedStorage:WaitForChild("Shared").ChildAdded:Connect(function(child)
    if child.Name == "OpenShop" then
        screenGui.Enabled = true
        child:Destroy()
    end
end)
