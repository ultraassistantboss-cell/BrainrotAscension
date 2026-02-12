const robot = require('robotjs');
const exec = require('child_process').exec;

exec('powershell -ExecutionPolicy Bypass -File focus_studio.ps1', (err, stdout, stderr) => {
    if (stdout.trim() === 'True') {
        console.log('Studio focused. Attempting Rojo Refresh...');
        // Move to Rojo panel Disconnect button
        robot.moveMouse(1850, 830);
        robot.mouseClick();
        console.log('Clicked at 1850, 830 (Disconnect?)');
        
        setTimeout(() => {
            // Click again (Connect?)
            robot.mouseClick();
            console.log('Clicked again (Connect?)');
            
            setTimeout(() => {
                // Move back to center
                robot.moveMouse(960, 540);
                console.log('Moved back to center.');
            }, 1000);
        }, 2000);
    } else {
        console.log('Failed to focus Studio');
    }
});
