local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GachaSpin = ReplicatedStorage:WaitForChild("GachaSpin")

-- Mapping Aura names to simple color effects
local AuraColors = {
    ["Skibidi Gray"] = Color3.fromRGB(128, 128, 128),
    ["Mewing Streak"] = Color3.fromRGB(0, 170, 255),
    ["Fanum Gold"] = Color3.fromRGB(255, 215, 0),
    ["STRAWBERRY ELEPHANT"] = Color3.fromRGB(255, 0, 100),
    ["GIGA CHAD TRANSCENDENCE"] = Color3.fromRGB(0, 0, 0)
}

local function applyAura(character, aura)
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Clear old aura
    for _, child in ipairs(rootPart:GetChildren()) do
        if child.Name == "SigmaAura" then
            child:Destroy()
        end
    end
    
    -- Create new visual effect (Simple Particle)
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "SigmaAura"
    particles.Color = ColorSequence.new(AuraColors[aura.Name] or Color3.new(1,1,1))
    particles.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
    particles.Rate = 50
    particles.Speed = NumberRange.new(2, 5)
    particles.Parent = rootPart
end

GachaSpin.OnClientEvent:Connect(function(aura)
    local player = game.Players.LocalPlayer
    if player.Character then
        applyAura(player.Character, aura)
    end
    print("NEW AURA ACQUIRED: " .. aura.Name)
end)