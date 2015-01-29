//
// Very simple main script. Fill in logic in the main function.
//
 
// save space by packing all strings
#pragma pack 1

#include <Log.inc>
#include <Script.inc>
#include <Sensor.inc>
#include <Motion.inc>
#include <Joint.inc>

#include "motions.inc"
 

public init() {
    print("main::init() enter\n");

    print("main::init() exit\n");
}

public main() {
    print("main::main() enter\n");
    joint_move_to(JOINT_NECK_VERTICAL, -50, 128, angle_degrees);
    
    for(;;) {
        new objectReading = sensor_get_value(SENSOR_OBJECT);

        if (objectReading > 40) {
            motion_play(mot_com_walk_fs);

            while (motion_is_playing(mot_com_walk_fs)) {
                sleep;
            }
        }

    }

    // left in, this generates an 'unreachable code' Pawn warning
    //print("main::main() exit\n");
}

public close() {
    print("main:close() enter\n");

    print("main:close() exit\n");
}
