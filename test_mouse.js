const robot = require('robotjs');
const mouse = robot.getMousePos();
console.log(`Current position: ${mouse.x}, ${mouse.y}`);
robot.moveMouse(mouse.x + 100, mouse.y + 100);
console.log(`Moved to: ${mouse.x + 100}, ${mouse.y + 100}`);
