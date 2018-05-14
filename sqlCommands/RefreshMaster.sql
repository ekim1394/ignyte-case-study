	-- refresh master table every 45 seconds
	CREATE OR REPLACE FUNCTION refreshMaster() RETURNS void as $$
	DECLARE
		l_id real;
		location office_location.location%TYPE;
		lat office_location.lat%TYPE;
		lon office_location.lon%TYPE;
		machine_type machine.machine_type%TYPE; 
		m_id machine.machine_id%TYPE;
		sensor_type sensor.sensor_type%TYPE;
		s_id sensor.sensor_id%TYPE;
		s_value sensor_readings.sensor_value%TYPE;
	BEGIN
		RAISE NOTICE 'REFRESHING MASTER TABLE';
		DELETE FROM master;
		FOR l_id in
			SELECT location_id FROM office_location
			LOOP
				RAISE NOTICE 'LOCATION ID {%}', l_id;
				select office_location.location into location from office_location where location_id = l_id;
				select office_location.lat into lat from office_location where location_id = l_id;
				select office_location.lon into lon from office_location where location_id = l_id;
				FOR m_id in
						SELECT machine_lookup.machine_id FROM machine_lookup where location_id = l_id
						LOOP
							select machine.machine_type into machine_type from machine where machine_id = m_id;
							FOR s_id in
								SELECT sensor_lookup.sensor_id FROM sensor_lookup where machine_id = m_id
								LOOP
									select sensor.sensor_type into sensor_type from sensor where sensor_id = s_id;
									FOR s_value in
										select sensor_readings.sensor_value from sensor_readings where sensor_id = s_id
										LOOP
											INSERT INTO master VALUES(DEFAULT, location, lat, lon, machine_type, m_id, sensor_type, s_id, s_value);
										END LOOP;
								END LOOP;
						END LOOP;
					
			END LOOP;
		RETURN;
	END;
	$$ LANGUAGE plpgsql;