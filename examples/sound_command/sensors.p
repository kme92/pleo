//
// Very simple sensors.p example. Add code to on_sensor for those
// sensors you would like to respond to.
//
 
// save space by packing all strings
#pragma pack 1

#include <Log.inc>
#include <Property.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <Sound.inc>

#include <pleo/age.inc>
#include <pleo/mood.inc>

// local includes
#include "commands.inc"
#include "user_properties.inc"


public init()
{
    print("sensors:init() enter\n");
    
    property_set(property_mood, mood_bored);
    property_set(property_age, age_baby);
    property_set(property_my_prop, age_baby);
    
    print("sensors:init() exit\n");
}

public on_sensor(time, sensor_name: sensor, value)
{
    new name[32];
    sensor_get_name(sensor, name);
    
    printf("sensors:on_sensor(%d, %s, %d)\n", time, name, value);
    
    switch (sensor)
    {
    case SENSOR_TAIL:
        {
            new mood = property_get(property_mood);
            printf("mood is now %d\n", mood);
            sound_command(cmd_snd_grunt);
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