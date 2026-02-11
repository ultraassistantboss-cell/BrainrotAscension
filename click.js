const robot = require('robotjs');
const args = process.argv.slice(2);

// SIGMA SPEED MODE
robot.setMouseDelay(0);

const x = parseInt(args[0]);
const y = parseInt(args[1]);
const action = args[2] || 'click'; // click, double, type, hover

if (!isNaN(x) && !isNaN(y)) {
    robot.moveMouse(x, y);
    
    if (action === 'click') {
        robot.mouseClick();
    } else if (action === 'double') {
        robot.mouseClick('left', true);
    } else if (action === 'right') {
        robot.mouseClick('right');
    } else if (action === 'type' && args[3]) {
        robot.mouseClick(); // Focus
        robot.typeString(args.slice(3).join(' '));
        robot.keyTap('enter');
    } else if (action === 'hover') {
        // Just move
    }
    
    console.log(`Action [${action}] at (${x}, ${y}) completed.`);
} else {
    console.log('Invalid input. Usage: node click.js <x> <y> [action] [text]');
}
