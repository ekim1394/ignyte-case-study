CREATE TABLE office_location (
	location_id serial PRIMARY KEY,
	location varchar(40) NOT NULL,
	lat real,
	lon real
);

CREATE TABLE machine (
	machine_type varchar(5),
	machine_id varchar(5) PRIMARY KEY
);

CREATE TABLE machine_lookup (
	machine_id varchar(5) REFERENCES machine(machine_id),
	location_id serial REFERENCES office_location(location_id)
);

CREATE TABLE sensor (
	sensor_type varchar(40),
	sensor_id varchar(10) PRIMARY KEY
);

CREATE TABLE sensor_lookup (
	machine_id varchar(5) REFERENCES machine(machine_id),
	sensor_id varchar(10) REFERENCES sensor(sensor_id)
);

CREATE TABLE sensor_readings (
	sensor_id varchar(10) REFERENCES sensor(sensor_id),
	sensor_value real
);