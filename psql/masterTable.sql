CREATE TABLE master (
	id serial PRIMARY KEY,
	location_id integer,
	location varchar(40),
	lat real,
	lon real,
	machine_type varchar(5),
	machine_id varchar(5),
	sensor_type varchar(40),
	sensor_id varchar(10),
	sensor_value real
);