COPY office_location
FROM '~\office_location.csv' DELIMITER ',' CSV HEADER

COPY machine
FROM '~\machine.csv' DELIMITER ',' CSV HEADER

COPY sensor
FROM '~\sensor.csv' DELIMITER ',' CSV HEADER

COPY machine_lookup
FROM '~\machine_lookup.csv' DELIMITER ',' CSV HEADER

COPY sensor_lookup
FROM '~\sensor_lookup.csv' DELIMITER ',' CSV HEADER

COPY sensor_readings
FROM '~\sensor_readings.csv' DELIMITER ',' CSV HEADER