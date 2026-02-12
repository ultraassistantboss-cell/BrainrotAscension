const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking test.rbxl (attempt 3)...');
        // Let's try to click slightly higher in the thumbnail
        robot.moveMouse(180, 600);
        robot.mouseClick();
    } else {
        console.log('Failed to focus Studio');
    }
});
