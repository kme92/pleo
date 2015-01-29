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
 

public init()
{
    print("main::init() enter\n");

    print("main::init() exit\n");
}

public main()
{
    print("main::main() enter\n");
    
    for(;;)
    {
        moveHead(JOINT_NECK_VERTICAL, -45);
        moveHead(JOINT_NECK_HORIZONTAL, 0);
        new frontEdgeReading = sensor_get_value(SENSOR_OBJECT);

        moveHead(JOINT_NECK_HORIZONTAL, 65);
        new rightEdgeReading = sensor_get_value(SENSOR_OBJECT);

        moveHead(JOINT_NECK_HORIZONTAL, -65);
        new leftEdgeReading = sensor_get_value(SENSOR_OBJECT);

        if (frontEdgeReading < 50)
	{
	    moveHead(JOINT_NECK_HORIZONTAL, 65);
	    rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
	    moveHead(JOINT_NECK_HORIZONTAL, -65);
	    leftEdgeReading = sensor_get_value(SENSOR_OBJECT);

	    if(rightEdgeReading < 60)
            {
                backLeft();
            } 
            else if (leftEdgeReading < 60)
            {
                backRight();
            }
	} 
        else 
        {
            walkForward();
        }

}

    // left in, this generates an 'unreachable code' Pawn warning
    //print("main::main() exit\n");
}

moveHead(direction, degrees)
{
//direction is JOINT_NECK_VERTICAL or JOINT_NECK_HORIZONTAL
//degrees vertical: 90 to -90
//degrees horizontal: 50 to -50

joint_move_to(direction, degrees, 128, angle_degrees);

while(joint_is_moving(direction))
	{
	sleep;
	}
}

backLeft() {
motion_play(mot_com_walk_br_2a);
while (motion_is_playing(mot_com_walk_br_2a))
            {
                sleep;
            }

motion_play(mot_com_walk_fl_short);
while (motion_is_playing(mot_com_walk_fl_short))
            {
                sleep;
            }
}

backRight() {
motion_play(mot_com_walk_bl_2a);
while (motion_is_playing(mot_com_walk_bl_2a))
            {
                sleep;
            }

motion_play(mot_com_walk_fr_short);
while (motion_is_playing(mot_com_walk_fr_short))
            {
                sleep;
            }
}

walkForward() 
{
motion_play(mot_com_walk_fs);
while (motion_is_playing(mot_com_walk_fs))
            {
                sleep;
            }
}

walkBackward()
{
motion_play(mot_com_walk_bs);
while (motion_is_playing(mot_com_walk_bs))
            {
                sleep;
            }
}

public close()
{
    print("main:close() enter\n");

    print("main:close() exit\n");
}
