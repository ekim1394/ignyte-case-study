COPY office_location
FROM '/data/office_location.csv' DELIMITER ',' CSV HEADER;

COPY machine
FROM '/data/machine.csv' DELIMITER ',' CSV HEADER;

COPY sensor
FROM '/data/sensor.csv' DELIMITER ',' CSV HEADER;

COPY machine_lookup
FROM '/data/machine_lookup.csv' DELIMITER ',' CSV HEADER;

COPY sensor_lookup
FROM '/data/sensor_lookup.csv' DELIMITER ',' CSV HEADER;

COPY sensor_readings
FROM '/data/sensor_readings.csv' DELIMITER ',' CSV HEADER;