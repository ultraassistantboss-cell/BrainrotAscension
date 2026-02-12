const robot = require('robotjs');
const exec = require('child_process').exec;

const buildScript = `
local Map = game.Workspace:FindFirstChild("SigmaCity") or Instance.new("Folder")
Map.Name = "SigmaCity"
Map.Parent = game.Workspace
for _, child in pairs(Map:GetChildren()) do child:Destroy() end
local floor = Instance.new("Part")
floor.Name = "MainFloor"
floor.Size = Vector3.new(2000, 1, 2000)
floor.Position = Vector3.new(0, -0.5, 0)
floor.Anchored = true
floor.Color = Color3.fromRGB(15, 23, 42)
floor.Material = Enum.Material.Concrete
floor.Parent = Map
local function spawnBuilding(pos, size, color)
    local b = Instance.new("Part")
    b.Name = "Skyscraper"
    b.Size = size
    b.Position = pos
    b.Anchored = true
    b.Material = Enum.Material.Glass
    b.Color = color or Color3.fromRGB(30, 41, 59)
    b.Parent = Map
end
for x = -800, 800, 200 do
    for z = -800, 800, 200 do
        if math.random() > 0.2 then
            local height = 200 + math.random(100, 400)
            spawnBuilding(Vector3.new(x, height/2, z), Vector3.new(80, height, 80))
        end
    end
end
print("B.O.S.S. BUILD SUCCESS")
`.replace(/\n/g, ' ');

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking Command Bar...');
        robot.moveMouse(500, 915);
        robot.mouseClick();
        robot.keyTap('a', 'control');
        robot.keyTap('backspace');
        robot.typeString(buildScript);
        robot.keyTap('enter');
        console.log('Command sent.');
    } else {
        console.log('Failed to focus Studio');
    }
});
