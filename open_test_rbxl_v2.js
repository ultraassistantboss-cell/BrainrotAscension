const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking test.rbxl (attempt 2)...');
        // Let's try to click exactly in the center of the thumbnail
        robot.moveMouse(180, 650);
        robot.mouseClick();
    } else {
        console.log('Failed to focus Studio');
    }
});
