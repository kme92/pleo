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
#include <Sound.inc>

#include "sounds.inc"
#include "motions.inc"

public hasSetup;

public init()
{
    print("main::init() enter\n");

    print("main::init() exit\n");
}

public main()
{
    print("main::main() enter\n");
    
    //initial setup
    while (hasSetup == false) {
	goNeutralPosition();
	moveHead(JOINT_NECK_VERTICAL, -50);
	
        moveHead(JOINT_NECK_HORIZONTAL, 65);
        new rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
        

	moveHead(JOINT_NECK_HORIZONTAL, -65);
        new leftEdgeReading = sensor_get_value(SENSOR_OBJECT);

        if (rightEdgeReading < leftEdgeReading) {
	    for(;;)
		{
		frontLeft();
	            moveHead(JOINT_NECK_VERTICAL, 20);
                    moveHead(JOINT_NECK_HORIZONTAL, 0);
 	            new reading = sensor_get_value(SENSOR_OBJECT);

	             if(reading < 20)
		     {
		         sound_play(snd_object_gt_0);
		     }
	             else if(reading > 20 && reading < 40)
		     {
		         sound_play(snd_object_gt_20);
		     }
	             else if(reading > 39 && reading < 60)
		     {
		         sound_play(snd_object_gt_40);
		     }
	             else if(reading > 59 && reading < 80)
		     {
		         sound_play(snd_object_gt_60);
		     }
	             else if(reading > 79 && reading < 100)
		     {
		         sound_play(snd_object_gt_80);
		     }
	             else
		     {
		         sound_play(snd_object_100);
		     }

	             if(reading > 40)
	             {
                         walkForward();	             
			}
	             else
	             {
		         frontLeft();
	             }
		}  
        } 
	else
	{
	for(;;)
		{
		frontRight();
	            moveHead(JOINT_NECK_VERTICAL, 20);
                    moveHead(JOINT_NECK_HORIZONTAL, 0);
 	            new reading = sensor_get_value(SENSOR_OBJECT);

	             if(reading < 20)
		     {
		         sound_play(snd_object_gt_0);
		     }
	             else if(reading > 20 && reading < 40)
		     {
		         sound_play(snd_object_gt_20);
		     }
	             else if(reading > 39 && reading < 60)
		     {
		         sound_play(snd_object_gt_40);
		     }
	             else if(reading > 59 && reading < 80)
		     {
		         sound_play(snd_object_gt_60);
		     }
	             else if(reading > 79 && reading < 100)
		     {
		         sound_play(snd_object_gt_80);
		     }
	             else
		     {
		         sound_play(snd_object_100);
		     }

	             if(reading > 40)
	             {
                         walkForward();	             
			}
	             else
	             {
		         frontRight();
	             }
		}  
	}

        hasSetup = true;
        //goNeutralPosition();
   }


   /*
    for(;;)
    {
        moveHead(JOINT_NECK_VERTICAL, -30);
        moveHead(JOINT_NECK_HORIZONTAL, 0);
        new frontEdgeReading = sensor_get_value(SENSOR_OBJECT);

        if (frontEdgeReading < 50)
	{
	    moveHead(JOINT_NECK_HORIZONTAL, 65);
	    new rightEdgeReading = sensor_get_value(SENSOR_OBJECT);
            if(rightEdgeReading < 60)
            {
                backLeft();
            } 

	    moveHead(JOINT_NECK_HORIZONTAL, -65);
	    new leftEdgeReading = sensor_get_value(SENSOR_OBJECT);
            if (leftEdgeReading < 60)
            {
                backRight();
            }
	} 
        else 
        {
            walkForward();
        }

    }*/


    // left in, this generates an 'unreachable code' Pawn warning
    //print("main::main() exit\n");
}

goNeutralPosition() {
    motion_play(mot_neutral);
    
    while (motion_is_playing(mot_neutral)) {
        sleep;
    }
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

frontLeft() {
    motion_play(mot_com_walk_fl_2a);
    while (motion_is_playing(mot_com_walk_fl_2a)) {
        sleep;
    }
}

frontRight() {
    motion_play(mot_com_walk_fr_2a);
    while (motion_is_playing(mot_com_walk_fr_2a)) {
        sleep;
    }
}

backLeft() {
    motion_play(mot_com_walk_br_2a);
    while (motion_is_playing(mot_com_walk_br_2a)) {
        sleep;
    }

    motion_play(mot_com_walk_fl_short);
    while (motion_is_playing(mot_com_walk_fl_short)) {
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
motion_play(mot_com_walk_fs_new);
while (motion_is_playing(mot_com_walk_fs_new))
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
