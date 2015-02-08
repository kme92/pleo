//
// IR Remote Control test. This test script will capture IR
// codes and print information to the monitor output. Tested with the 
// Acroname R278-IR-REMOTE: http://www.acroname.com/robotics/parts/R278-IR-REMOTE.html
//
// Copyright(c) 2008 Ugobe, Inc.
//

// Native functions
//
#include <Log.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <String.inc>


// called once on entry
//
public init()
{
    // disable all messages except ours ('script:')
    log_disable(MSG_ALL);
    log_enable(MSG_SCRIPT);
    
    // all print and printf output is tagged as 'script:'
    printf("IR REMOTE TEST\nCompatible with Acroname R278-IR-REMOTE NEC-protocol remote control.\n");
}


// called on each sensor trigger
//
public on_sensor(time, sensor_name:sensor, value)
{
    switch (sensor)
    {
        case SENSOR_IR:
        {
            new imsg[16];
            sensor_read_data(SENSOR_IR, imsg);
                    
            printf("=== SENSOR_IR, msg received %s ===\n", imsg);
            
            if (string_compare(imsg, "1600") == 0)      // '1' key
            {
                printf("KEY 1\n");
            }
            else if (string_compare(imsg, "1500") == 0) // '2' key
            {
                printf("KEY 2\n");
            }
            else if (string_compare(imsg, "1400") == 0) // '3' key
            {
                printf("KEY 3\n");
            }
            else if (string_compare(imsg, "0E00") == 0) // '4' key
            {
                printf("KEY 4\n");
            }
            else if (string_compare(imsg, "0D00") == 0) // '5' key
            {
                printf("KEY 5\n");
            }
            else if (string_compare(imsg, "0C00") == 0) // '6' key
            {
                printf("KEY 6\n");
            }
            else if (string_compare(imsg, "0A00") == 0) // '7' key
            {
                printf("KEY 7\n");
            }
            else if (string_compare(imsg, "0900") == 0) // '8' key
            {
                printf("KEY 8\n");
            }
            else if (string_compare(imsg, "0800") == 0) // '9' key
            {
                printf("KEY 9\n");
            }
            else if (string_compare(imsg, "0600") == 0) // '10' key
            {
                printf("KEY 10\n");
            }
            else if (string_compare(imsg, "0500") == 0) // '11' key
            {
                printf("KEY 11\n");
            }
            else if (string_compare(imsg, "0400") == 0) // '12' key
            {
                printf("KEY 12\n");
            }
            else if (string_compare(imsg, "0100") == 0) // '13' key
            {
                printf("KEY 13\n");
            }
            else if (string_compare(imsg, "0000") == 0) // '14' key
            {
		// this may not occur since we filter 0 IR values
                printf("KEY 14\n");
            }
            else 
            {
                printf("Unhandled key\n");
            }
        }
    }

// returning true will cause the sensor to be reset. if we do not
// do this, we will continue to be called, unless we do an explicit resetSensor call

    return true;
}


// called when we exit, just before unloading
//
public close()
{
    printf("close\n");
}
