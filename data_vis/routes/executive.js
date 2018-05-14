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

var globalAvg;
var globalStd;
var globalMax;
var globalMin;

router.get('/', async (req, res) => {
  const { rows } = await db.query("SELECT AVG(sensor_value), STDDEV(sensor_value), MAX(sensor_value), MIN(sensor_value) FROM master");
  globalAvg = rows[0].avg;
  globalStd = rows[0].stddev;
  globalMax = rows[0].max;
  globalMin = rows[0].min;
  res.render("executive", {
    title: "Executive Dashboard",
    avg: rows[0].avg,
    std: rows[0].stddev,
    max: rows[0].max,
    min: rows[0].min  
  })
})

router.get('/:location_id', async (req, res) => {
  const { location_id } = req.params;
  var location = locations[location_id];
  const { rows } = await db.query("SELECT AVG(sensor_value), STDDEV(sensor_value), MAX(sensor_value), MIN(sensor_value) FROM master WHERE location = $1", [location]);
  res.render('executive', {
    title: location + " Dashboard",
    location: location,
    avg:  rows[0].avg,
    std: rows[0].stddev,
    max: rows[0].max,
    min: rows[0].min
  })
})

module.exports = router
