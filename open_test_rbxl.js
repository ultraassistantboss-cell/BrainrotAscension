const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking test.rbxl...');
        // Clicking the "test.rbxl" tile
        robot.moveMouse(180, 700);
        robot.mouseClick();
    } else {
        console.log('Failed to focus Studio');
    }
});
