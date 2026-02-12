const robot = require('robotjs');
const exec = require('child_process').exec;
exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking Disconnect...');
        robot.moveMouse(1850, 830);
        robot.mouseClick();
        setTimeout(() => {
            console.log('Clicking Connect...');
            robot.moveMouse(1850, 830);
            robot.mouseClick();
        }, 1000);
    } else {
        console.log('Failed to focus Studio');
    }
});
