const eeprom = require(__dirname + '/eeprom.js');

(async () => {
    const data = await eeprom.info();

    console.log(data);
})()
