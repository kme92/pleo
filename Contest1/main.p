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

moveHead(JOINT_NECK_VERTICAL, -50);
moveHead(JOINT_NECK_HORIZONTAL, 0);
new frontEdgeReading = sensor_get_value(SENSOR_OBJECT);

    if(frontEdgeReading < 60)
	{
	moveHead(JOINT_NECK_HORIZONTAL, 65);
	new rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
	
	if(rightEdgeReading < 40) { turnLeft(); }
	else {turnRight();}
		
	}
else {
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
}

turnLeft() {

motion_play(mot_com_walk_fl_short);
while (motion_is_playing(mot_com_walk_fl_short))
            {
                sleep;
            }

/*new rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
while(rightEdgeReading < 40)
	{
motion_play(mot_com_walk_fl_short);
while (motion_is_playing(mot_com_walk_fl_short))
            {
                sleep;
            }
moveHead(JOINT_NECK_HORIZONTAL, 0);
rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
	}*/

}

turnRight() {

motion_play(mot_com_walk_fr_short);
while (motion_is_playing(mot_com_walk_fr_short))
            {
                sleep;
            }

/*new leftEdgeReading = sensor_get_value(SENSOR_OBJECT);
while(leftEdgeReading < 40)
	{
motion_play(mot_com_walk_fr_short);
while (motion_is_playing(mot_com_walk_fr_short))
            {
                sleep;
            }
moveHead(JOINT_NECK_HORIZONTAL, 0);
leftEdgeReading = sensor_get_value(SENSOR_OBJECT);
	}
*/

}

walkForward() 
{
motion_play(mot_com_walk_fs);
while (motion_is_playing(mot_com_walk_fs))
            {
                sleep;
            }
}

public close()
{
    print("main:close() enter\n");

    print("main:close() exit\n");
}
