local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClickEvent = ReplicatedStorage:WaitForChild("ClickEvent")

local player = Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Create Click UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ClickGui"
screenGui.IgnoreGuiInset = true
screenGui.Parent = pgui

local clickButton = Instance.new("TextButton")
clickButton.Name = "MainClicker"
clickButton.Size = UDim2.new(0, 200, 0, 200)
clickButton.Position = UDim2.new(0.5, -100, 0.5, -100)
clickButton.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
clickButton.Text = "CLICK FOR BRAINCELLS"
clickButton.Font = Enum.Font.GothamBold
clickButton.TextColor3 = Color3.new(1, 1, 1)
clickButton.TextSize = 20
clickButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = clickButton

-- Animation Logic
local function playBounce()
    clickButton:TweenSize(UDim2.new(0, 220, 0, 220), "Out", "Quad", 0.05, true)
    task.wait(0.05)
    clickButton:TweenSize(UDim2.new(0, 200, 0, 200), "Out", "Quad", 0.05, true)
end

clickButton.MouseButton1Click:Connect(function()
    ClickEvent:FireServer()
    playBounce()
end)