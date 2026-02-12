const robot = require('robotjs');
const screenSize = robot.getScreenSize();
const targetX = screenSize.width / 2;
const targetY = screenSize.height / 2;
robot.moveMouse(targetX, targetY);
console.log(`Centered mouse at ${targetX}, ${targetY}`);
