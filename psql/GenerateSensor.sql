-- Generate sensor data every 30 seconds
CREATE OR REPLACE FUNCTION generateSensorData(spike BOOLEAN) RETURNS void AS $$
DECLARE
	s_id sensor.sensor_id%TYPE;
	m_id machine.machine_id%TYPE;
	m_id0 machine.machine_id%TYPE;
	m_id1 machine.machine_id%TYPE;
	l_id office_location.location_id%TYPE;
	l_id0 office_location.location_id%TYPE;
	l_id1 office_location.location_id%TYPE;
BEGIN
	RAISE NOTICE 'CREATING RANDOM RECORDS FOR EACH SENSOR';
	l_id0 := ceiling(random()*.5*10);
	l_id1 := ceiling(random()*.5*10);
	WHILE l_id0 = l_id1 
	LOOP
		l_id1 := ceiling(random()*.5*10);
	END LOOP;
	select machine_id into m_id0 from machine_lookup where location_id = l_id0 order by random() limit 1;
	select machine_id into m_id1 from machine_lookup where location_id = l_id1 order by random() limit 1;
	IF spike THEN
		RAISE NOTICE 'SPIKE in locations % and % for machines % and %', l_id0, l_id1, m_id0, m_id1;
	ELSE
		RAISE NOTICE 'Normal Readings';
	END IF;
	FOR l_id IN
		SELECT location_id FROM office_location
	LOOP
		FOR m_id IN
			select machine_id from machine_lookup where location_id = l_id
			LOOP
				IF spike AND (m_id = m_id0 OR m_id = m_id1) THEN
					FOR s_id IN
						select sensor_id from sensor_lookup where machine_id = m_id
						LOOP
							RAISE NOTICE 'SPIKE IN Machine %', m_id;
							INSERT INTO sensor_readings VALUES(s_id, random()+.5);
						END LOOP;
				ELSE
					FOR s_id IN
						select sensor_id from sensor_lookup where machine_id = m_id
						LOOP
							INSERT INTO sensor_readings VALUES(s_id, random()*.5);
						END LOOP;
				END IF;
			END LOOP;
	END LOOP;
	RAISE NOTICE 'FINISHED INSERTING NEW RECORDS';
	RETURN;
END;
$$ LANGUAGE plpgsql;