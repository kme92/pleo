#pragma pack 1

#include <Log.inc>
#include <Script.inc>
#include <Sound.inc>
#include <Motion.inc>
#include <Sensor.inc>
#include <Joint.inc>

#include "sounds.inc"
#include "motions.inc"

new targetCounter = 0; // the amount of targets that were knocked down
new phase = 1; // the state to perform a particular algorithm
new found = 0; // a flag to determine if an object has been detected
new threshold = 40; // the threshold value for object sensing
new firstTurnLeft = true;

// global motion variables
/*
    f = forward
    b = backward
    l = left
    r = right
    h = head
    d = down
    u = up
*/
new walk_f_1step = mot_com_walk_fl_1step;
new walk_f_1step_alt = mot_com_walk_fr_1step;
new walk_hd = mot_walk_hdr;
new walk_f_2a = mot_com_walk_fl_2a;
new walk_bh = mot_walk_blhl;
new scan65 = 65;
new scan30 = 30;


public init()
{
    // check which side the pleo starts on and heads to the first target
    sound_set_volume(200);
    playMotion(mot_neutral, 1);
    readSensor(SENSOR_BATTERY);
    playSound(snd_stawded);

    moveHead(JOINT_NECK_VERTICAL, -10);
    new right = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);

    moveHead(JOINT_NECK_VERTICAL, -10);
    new left = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65);

    setFirstTurn(right, left);
    playMotion(walk_f_2a, 2);
}

public main()
{
    while (true)
    {
        // Phase 1: Edge Following
        if (targetCounter == 1 && phase == 1)
        {
            new seenEdge = 0;
            new loops = 0;

            if (firstTurnLeft)
            {
                loops = 7;
            } 
            else
            {
                loops = 5;
            }

            for (new i = 0; i < loops; i++)
            {
                moveHead(JOINT_NECK_VERTICAL, -15);
                playMotion(walk_hd, 1);
                if (i == 3 && seenEdge == 0)
                {
                    playMotion(walk_f_1step_alt, 1);
                    moveHead(JOINT_NECK_VERTICAL, -15);
                }

                new edge = moveHeadAndSense(JOINT_NECK_HORIZONTAL, scan65);
                if (edge < threshold)
                {
                    seenEdge = 1;
                    playMotion(walk_f_1step, 1);
                }
                playMotion(walk_hd, 1);
            }
            playMotion(walk_f_1step, 1);
            phase++;
        }

        // Phase 2: 3pt Targets
        if (targetCounter == 2 && phase == 2)
        {
            if (firstTurnLeft)
            {
                // brhr 2 is too much
                playMotion(mot_walk_brhr, 1);
                playMotion(mot_com_walk_bs, 2);
            }
            else
            {
                playMotion(mot_com_walk_bs, 3);
            }
            playMotion(walk_f_1step, 1);
            
            phase++;
        }

        // Phase 3: First 2pt Target
        if (targetCounter == 3 && phase == 3)
        {
            if (firstTurnLeft)
            {
                playMotion(walk_f_1step, 2);
            }
            else
            {
                playMotion(walk_f_1step, 2);
            }
            // 5 good but risky
            playMotion(mot_walk_hu, 4);
            phase++;
        }

        // Phase 4: Second 2pt Target
        if (targetCounter == 4 && phase == 4)
        {
            // knocks down second last one
            playMotion(walk_bh, 2);
            playMotion(mot_walk_hu, 5);
            phase++;
        }

        // Phase 5: Final Target and Closing
        if (targetCounter == 5 && phase == 5)
        {
            playSound(snd_what);
            playMotion(mot_neutral, 1);
            playSound(snd_started_from_the_bottom);
            playMotion(mot_wag_front_back, 1);    
            phase++; // ends the program
        } 
        else if (phase != 6)
        {
            findObject();
        }
    }
    // left in, this generates an 'unreachable code' Pawn warning
    //print("main::main() exit\n");
}

public close()
{
    //close
}

setFirstTurn(right, left)
{
    // changes motions with respect to the side it starts on
    if (right > left)
    {
        walk_f_1step = mot_com_walk_fr_1step;
        walk_f_1step_alt = mot_com_walk_fl_1step;
        walk_hd = mot_walk_hdl;
        walk_f_2a = mot_com_walk_fr_2a;
        walk_bh = mot_walk_brhr;
        scan65 = -65;
        scan30 = -30;
        firstTurnLeft = false;
    }
}

moveHeadAndSense(direction, degrees)
{
    // direction is JOINT_NECK_VERTICAL or JOINT_NECK_HORIZONTAL
    // degrees vertical: 90 to -90
    // degrees horizontal: 50 to -50
    new degreesOffset5 = 0;
    new degreeOffset1 = 0;
    new motionSpeed = 180;

    if (degrees > 0)
    {
        degreesOffset5 = degrees - 5;
        degreeOffset1 = 1;
    }
    else
    {
        degreesOffset5 = degrees + 5;
        degreeOffset1 = -1;
    }

    moveHead(direction, degreesOffset5 + degreeOffset1);

    playSound(snd_beep_silent); // sound used to force a delay

    moveHead(direction, degrees + degreeOffset1);
    moveHead(direction, degreesOffset5);

    playSound(snd_beep);

    moveHead(direction, degrees);

    return readSensor(SENSOR_OBJECT); 
}

playMotion(motion, times)
{
    // plays a motion for a specified amount of times
    for (new i=0; i < times; i++)
    {
        motion_play(motion);
        while (motion_is_playing(motion))
        {
            sleep;
        }
    }
}

moveHead(direction, degrees)
{
    // direction is JOINT_NECK_VERTICAL or JOINT_NECK_HORIZONTAL
    // degrees vertical: 90 to -90
    // degrees horizontal: 50 to -50

    joint_move_to(direction, degrees, 180, angle_degrees);

    while (joint_is_moving(direction))
    {
        sleep;
    }
}

readSensor(sensor)
{
    // read out objec sensor values (used for debugging)
    new detection = sensor_get_value(sensor);

    switch (detection)
    {
        case 0 .. 19: { playSound(snd_debug0); }
        case 20 .. 39: { playSound(snd_debug20); }
        case 40 .. 59: { playSound(snd_debug40); }
        case 60 .. 79: { playSound(snd_debug60); }
        case 80 .. 99: { playSound(snd_debug80); }
        case 100: { playSound(snd_debug100); }
        default: { playSound(snd_debug0); }
    }

    return detection;      
}

playSound(sound) 
{
    sound_play(sound);
    while (sound_is_playing(sound))
    {
        sleep;
    }
}

findObject()
{
    // Checks front and sides for a target, moves closer to the object
    // until knocking it down. Once a target is knocked down, there is a
    // final check to verify before incrementing the targetCounter by 1 
    new previouslyFound = found;

    moveHead(JOINT_NECK_HORIZONTAL, 7);
 
    new front = moveHeadAndSense(JOINT_NECK_VERTICAL, 27);

    if (front > threshold)
    {
        found = 1;
        playMotion(mot_walk_hu, 1);
    }
    else 
    {
        new first65 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, scan65 * (-1));

        if (first65 > threshold)
        {
            found = 1;
            playMotion(walk_f_1step, 1);
        }
        else
        {
            new first30 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, scan30 * (-1));

            if (first30 > threshold)
            {
                found = 1;
                playMotion(walk_f_1step, 1);
            }
            else
            {
                new second65 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, scan65);

                if (second65 > threshold)
                {
                    found = 1;
                    playMotion(walk_f_1step_alt, 1);
                }
                else
                {
                    new second30 =moveHeadAndSense(JOINT_NECK_HORIZONTAL, scan30);

                    if (second30 > threshold)
                    {
                        found = 1;
                        playMotion(walk_f_1step_alt, 1);
                    }
                    else
                    {
                        found = 0;

                        if (previouslyFound)
                        {
                            targetCounter++;
                            playSound(snd_yeah);
                        }
                        else
                        {
                            playMotion(mot_walk_hu, 1);  
                        }
                    }
                }
            }
        }
    }
}
