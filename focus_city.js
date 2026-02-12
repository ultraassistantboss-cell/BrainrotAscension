const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking SigmaCity and pressing F...');
        // Workspace is at ~185, SigmaCity should be around 250
        robot.moveMouse(1850, 250);
        robot.mouseClick();
        robot.keyTap('f');
    } else {
        console.log('Failed to focus Studio');
    }
});
