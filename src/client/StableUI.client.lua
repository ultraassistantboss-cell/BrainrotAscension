local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemeMeta = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("MemeMeta"))

-- Centralized UI Creation
local function createMainUI(player)
    local pgui = player:WaitForChild("PlayerGui")
    
    -- Main ScreenGui
    local screenGui = pgui:FindFirstChild("SigmaMainGui") or Instance.new("ScreenGui")
    screenGui.Name = "SigmaMainGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 10 -- Ensure it's above other UIs
    screenGui.Parent = pgui

    -- Click Button
    local clickButton = screenGui:FindFirstChild("MainClicker") or Instance.new("TextButton")
    clickButton.Name = "MainClicker"
    clickButton.Size = UDim2.new(0, 200, 0, 200) -- Bigger for more Sigma energy
    clickButton.Position = UDim2.new(0.5, -100, 0.85, -100)
    clickButton.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
    clickButton.Text = "CLICK"
    clickButton.Font = Enum.Font.GothamBold
    clickButton.TextColor3 = Color3.new(1, 1, 1)
    clickButton.TextSize = 35
    clickButton.ZIndex = 5
    clickButton.Parent = screenGui
    
    if not clickButton:FindFirstChild("UICorner") then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = clickButton
    end

    -- Stats Display
    local statsFrame = screenGui:FindFirstChild("StatsFrame") or Instance.new("Frame")
    statsFrame.Name = "StatsFrame"
    statsFrame.Size = UDim2.new(0, 200, 0, 100)
    statsFrame.Position = UDim2.new(0, 20, 0, 20)
    statsFrame.BackgroundTransparency = 1
    statsFrame.Parent = screenGui

    local function createStatLabel(name, pos, color)
        local label = statsFrame:FindFirstChild(name) or Instance.new("TextLabel")
        label.Name = name
        label.Size = UDim2.new(1, 0, 0, 30)
        label.Position = pos
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = color
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = statsFrame
        return label
    end

    local cellLabel = createStatLabel("CellLabel", UDim2.new(0,0,0,0), Color3.fromRGB(56, 189, 248))
    local auraLabel = createStatLabel("AuraLabel", UDim2.new(0,0,0,35), Color3.fromRGB(255, 0, 100))
    local rankLabel = createStatLabel("RankLabel", UDim2.new(0,0,0,70), Color3.fromRGB(245, 158, 11))

    -- Update Loop
    local function updateStats()
        local stats = player:WaitForChild("leaderstats", 5)
        if stats then
            cellLabel.Text = "Cells: " .. (stats:FindFirstChild("Brain Cells") and stats["Brain Cells"].Value or 0)
            auraLabel.Text = "Aura: " .. (stats:FindFirstChild("Aura") and stats["Aura"].Value or 0)
            rankLabel.Text = "Rank: " .. (stats:FindFirstChild("Sigma Level") and stats["Sigma Level"].Value or "N/A")
        end
    end

    player:WaitForChild("leaderstats").ChildAdded:Connect(updateStats)
    task.spawn(function()
        while true do
            updateStats()
            task.wait(0.5)
        end
    end)

-- Click Logic
    local debounce = false
    clickButton.MouseButton1Click:Connect(function()
        if debounce then return end
        debounce = true
        
        -- Local visual feedback
        local originalSize = clickButton.Size
        clickButton:TweenSize(UDim2.new(0, 215, 0, 215), "Out", "Quad", 0.05, true)
        task.wait(0.05)
        clickButton:TweenSize(originalSize, "Out", "Quad", 0.05, true)
        
        -- Create a text pop-up animation
        local popupText = Instance.new("TextLabel")
        popupText.Text = "+1" 
        popupText.Font = Enum.Font.GothamBold
        popupText.TextSize = 30
        popupText.TextColor3 = Color3.fromRGB(255, 255, 0)
        popupText.BackgroundTransparency = 1
        popupText.Position = UDim2.new(0.5, math.random(-100, 100), 0.7, math.random(-50, 50))
        popupText.Size = UDim2.new(0, 100, 0, 30)
        popupText.ZIndex = 10
        popupText.Parent = screenGui
        
        popupText:TweenPosition(UDim2.new(popupText.Position.X.Scale, popupText.Position.X.Offset, popupText.Position.Y.Scale - 0.2, popupText.Position.Y.Offset), "Out", "Quad", 0.4, true)
        
        game:GetService("Debris"):AddItem(popupText, 0.4)
        
        ReplicatedStorage:WaitForChild("ClickEvent"):FireServer()
        
        task.wait(0.1)
        debounce = false
    end)
end

-- Initialize for local player only
createMainUI(Players.LocalPlayer)
