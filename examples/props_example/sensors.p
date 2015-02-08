//
// sensors.p
// Properties Example
//
// This sensors.p script runs in the Sensors VM. It
// watches sensors and sets properties to notify the 
// other scripts of certain events.
//
// The sensors used in this example are derived sensors
// and they may require that you use special methods to
// modify them. See the PDK documentation for more details.
//
 
// save space by packing all strings
#pragma pack 1

#include <Log.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <Property.inc>

#include "user_properties.inc"

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
        // SENSOR_TOUCH_HOLD tells us that a sensor
        // is being held - the value passed by SENSOR_TOUCH_HOLD 
        // is equal to the sensor that is being held.
        case SENSOR_TOUCH_HOLD:
        {
            if (sensor_name:value == SENSOR_HEAD)
            {
                // Let other scripts know that the sensor
                // is being held.
                property_set(property_head_held, 1);
            }
        }
        
        // SENSOR_TOUCH_RELEASE tells us that a sensor
        // that was being held was released - the value passed by 
        // SENSOR_TOUCH_RELEASE is equal to the sensor that was
        // just released.
        case SENSOR_TOUCH_RELEASE:
        {
            if (sensor_name:value == SENSOR_HEAD)
            {
                // Let other scripts know that the sensor
                // has been released.
                property_set(property_head_held, 0);
            }
        }

        // SENSOR_TOUCH_TAP tells us that a sensor
        // has been tapped - the value passed by SENSOR_TOUCH_TAP 
        // is equal to the sensor that is being held.
        case SENSOR_TOUCH_TAP:
        {
            if (sensor_name:value == SENSOR_HEAD)
            {
                // Let other scripts know that the head
                // sensor has been tapped.
                property_set(property_head_tapped, 1);
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