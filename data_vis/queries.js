const {
  Pool
} = require('pg')

const pool = new Pool({
  host: '192.168.99.100',
  user: 'postgres',
  password: 'password',
  database: 'postgres',
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
})

var i = 1;

async function populateSensorData() {
  if (i % 3 == 0) {
    console.log("Generating Spiked Data");
    try {
      await pool.query("SELECT generateSensorData(true)");
    } catch (err) {
      console.error("Error occurred when trying to connect to database", err);
    }
    i = 0;
  } else {
    console.log("Generating sensor data")
    try {
      await pool.query("SELECT generateSensorData(false)");
    } catch (err) {
      console.error("Error occurred when trying to connect to database", err);
    }
  }

  i++;
}

async function refreshMaster() {
  console.log("Refreshing Master Table");
  try {
    await pool.query("SELECT refreshMaster()");
  } catch (err) {
    console.error("Error occurred when connecting to DB", err);
  }
}

module.exports = {
  query: (text, params) => pool.query(text, params),
  refreshMaster: refreshMaster,
  generateSensorData: populateSensorData,
  pool: pool
}