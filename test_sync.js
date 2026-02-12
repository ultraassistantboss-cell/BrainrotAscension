const robot = require('robotjs');
const exec = require('child_process').exec;

const testScript = 'print("PART COUNT: " .. #game.Workspace.SigmaCity:GetChildren())';

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Typing test script...');
        robot.moveMouse(500, 915);
        robot.mouseClick();
        robot.keyTap('a', 'control');
        robot.keyTap('backspace');
        robot.typeString(testScript);
        robot.keyTap('enter');
    } else {
        console.log('Failed to focus Studio');
    }
});
