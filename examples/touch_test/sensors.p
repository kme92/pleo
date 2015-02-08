//
// Very simple sensors.p example. Add code to on_sensor for those
// sensors you would like to respond to.
//
 
// save space by packing all strings
#pragma pack 1

#include <Log.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <Sound.inc>

#include "sounds.inc"


public init()
{
    print("sensors:init() enter\n");
    
    print("sensors:init() exit\n");
}

public on_sensor(time, sensor_name: sensor, value)
{
    new name[32];
    sensor_get_name(sensor, name);
    
    printf("sensors:on_sensor(%d, %s, %d)\n", time, name, value);
    
    switch (sensor)
    {
    case SENSOR_BACK:
    	if (value == 0)
    	{
    		sound_play(snd_growl);
    	}
    }
    
	// reset sensor trigger
    return true;
}

public close()
{
    print("sensors:close() enter\n");

    print("sensors:close() exit\n");
}