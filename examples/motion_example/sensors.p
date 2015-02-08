//
// sensors.p
// Motion Example
//
// This script demonstrates how to play an animation on 
// Pleo, including an animation that has embedded sound files.
//
 
// save space by packing all strings
#pragma pack 1

#include <Log.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <Motion.inc>

#include "motions.inc"


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

        
        // If Pleo is touched on the head, play a
        // "get up" motion.
        case SENSOR_HEAD: 
        {
            
            motion_play(mot_nap_getup);
            
            // Pause and wait for the motion to finish playing.
            while (motion_is_playing(mot_nap_getup))
            {
                sleep;
            }
        
        }    

        // If someone touches Pleo's rear sensor, play a
        // laydown to rest motion.
        case SENSOR_ARSE:
        {
        
            motion_play(mot_laydown);
            
            // Pause and wait for the motion to finish playing.
            while (motion_is_playing(mot_laydown))
            {
                sleep;
            }
        
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