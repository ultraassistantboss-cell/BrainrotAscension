const robot = require('robotjs');
const exec = require('child_process').exec;

const camScript = `workspace.CurrentCamera.CFrame = CFrame.new(Vector3.new(0, 500, 1000), Vector3.new(0, 0, 0))`;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Setting Camera...');
        robot.moveMouse(500, 915);
        robot.mouseClick();
        robot.keyTap('a', 'control');
        robot.keyTap('backspace');
        robot.typeString(camScript);
        robot.keyTap('enter');
    } else {
        console.log('Failed to focus Studio');
    }
});
