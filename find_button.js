const robot = require('robotjs');
const screenSize = robot.getScreenSize();
const startX = screenSize.width - 300;
const startY = screenSize.height - 300;

console.log(`Scanning from ${startX}, ${startY} to ${screenSize.width}, ${screenSize.height}`);

for (let y = startY; y < screenSize.height; y += 10) {
    for (let x = startX; x < screenSize.width; x += 10) {
        const color = robot.getPixelColor(x, y);
        // Look for Red (Disconnect button) or Green/Gray (Connect button)
        // Red is usually like #d... or #f...
        if (color.startsWith('d') || color.startsWith('e') || color.startsWith('f')) {
            // Check if it's mostly red
            const r = parseInt(color.substring(0, 2), 16);
            const g = parseInt(color.substring(2, 4), 16);
            const b = parseInt(color.substring(4, 6), 16);
            if (r > 150 && g < 100 && b < 100) {
                console.log(`Found Red at ${x}, ${y}: ${color}`);
                // robot.moveMouse(x, y);
                // break;
            }
        }
    }
}
