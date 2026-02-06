local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClickEvent = ReplicatedStorage:WaitForChild("ClickEvent")

local debounce = false
local CLICK_COOLDOWN = 0.1

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if not debounce then
            debounce = true
            ClickEvent:FireServer()
            task.wait(CLICK_COOLDOWN)
            debounce = false
        end
    end
end)