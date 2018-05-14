const Router = require('express-promise-router')
const db = require('../queries')
const router = new Router()

const locations = {
    "1": "Boston",
    "2": "New York",
    "3": "Denver",
    "4": "Atlanta",
    "5": "Seattle",
}

router.get('/', (req, res) => {
    res.render('operations', {
        title: "Operations View"
    });
})

router.get('/:location_id', async (req, res) => {
    const { location_id } = req.params;
    const { rows } = await db.query("SELECT machine_id FROM machine_lookup WHERE location_id = $1", [location_id]);
    var machineList = []
    for (i = 0; i < rows.length; i++) {
        machineList.push(rows[i].machine_id);
    }
    
    var machineStatsList = [];
    for (i = 0; i < machineList.length; i++) {
        machine_id = machineList[i];
        const { rows } = await db.query("SELECT AVG(sensor_value), STDDEV(sensor_value), MAX(sensor_value), MIN(sensor_value) FROM master WHERE machine_id = $1", [machine_id]);
        machineStatsList.push({
            id: machine_id,
            stats: {
                avg: rows[0].avg,
                std: rows[0].stddev,
                min: rows[0].min,
                max: rows[0].max
            }
        });
    }
    res.render('operations', {
        location: locations[location_id],
        machineList: machineStatsList,
        location_id: location_id,
    })
})

router.get('/:location_id/:machine_id', async (req, res) => {
    const { location_id, machine_id } = req.params;
    const { rows } = await db.query("SELECT sensor_id, sensor_value FROM master WHERE machine_id = $1", [machine_id]);
    var sensorValueList = []
    for (i = 0; i < rows.length; i++) {
        sensorValueList.push({
            id: rows[i].sensor_id,
            sensor_value: rows[i].sensor_value
        });
    }
    res.render('operations', {
        sensorValues: sensorValueList,
        machine_id: machine_id,
    })

})

module.exports = router