const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Clicking DISCONNECT at 1840, 895...');
        robot.moveMouse(1840, 895);
        robot.mouseClick();
        
        setTimeout(() => {
            console.log('Clicking CONNECT at 1840, 895...');
            robot.mouseClick();
            
            setTimeout(() => {
                console.log('Rojo Refresh Sequence Complete.');
            }, 1000);
        }, 3000); // 3 second delay to ensure it updates
    } else {
        console.log('Failed to focus Studio');
    }
});
