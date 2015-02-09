//
// Very simple main script. Fill in logic in the main function.
//
 
// save space by packing all strings
#pragma pack 1

// 
#include <Log.inc>
#include <Script.inc>
#include <Sound.inc>
#include <Motion.inc>
#include <Sensor.inc>
#include <Joint.inc>

#include "sounds.inc"
#include "motions.inc"

new targetKnockedDown = 0;
new targetCounter = 0;
new phase = 0;
new found = 0;
new threshold = 40;

public init()
{
    print("main::init() enter\n");
   
    print("main::init() exit\n");
}

public main()
{
    print("main::main() enter\n");

//initialize

    sound_set_volume(200);
    goNeutralPosition();
    playSound(snd_stawded);
//check which side
    initialize();
            
//find first object
    while(true){
        if(targetCounter == 1 && phase == 0)
        {
            new i = 0;
            for(i=0;i<6; i++)
            {
                playMotion(mot_walk_hdr, 1);
                new rightEdge = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);
                if(rightEdge < 40)
                {
                    playMotion(mot_com_walk_fl_1step, 1);
                }              
                playMotion(mot_walk_hdr, 1);
            }
            playMotion(mot_com_walk_fl_1step, 1);
            phase++;
        }

        if(targetCounter == 2 && phase == 1)
        {
            new backCounter;
            while(moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65) < 40)
            { 
                playMotion(mot_com_walk_bs, 2);
                playMotion(mot_com_walk_fl_2a, 1);
            }
            
            playMotion(mot_com_walk_fl_1step, 1);
            phase++;
        }

        if(targetCounter == 3 && phase == 2)
        {
            playMotion(mot_com_walk_fl_1step, 2);
            playMotion(mot_walk_hu, 3);
            phase++;
        }

        if(targetCounter == 4 && phase == 3)
        {
            playMotion(mot_walk_blhl, 1);
            playMotion(mot_walk_hu, 2);
            phase++;
        }
        findObject();
    }



    // left in, this generates an 'unreachable code' Pawn warning
    //print("main::main() exit\n");
}

public close()
{
    print("main:close() enter\n");

    print("main:close() exit\n");
}

goNeutralPosition() {
    playMotion(mot_neutral, 1);
}

initialize(){

    moveHead(JOINT_NECK_VERTICAL, -20);
    new right = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);
    //right = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);
    moveHead(JOINT_NECK_VERTICAL, -20);
    new left = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65);
    //left = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65);

    if (right < left){
        frontLeft();
        frontLeft();
    }
    if (right > left){        
        frontRight();
        frontRight();   
    }
}

moveHeadAndSense(direction, degrees){
//direction is JOINT_NECK_VERTICAL or JOINT_NECK_HORIZONTAL
//degrees vertical: 90 to -90
//degrees horizontal: 50 to -50
    new degreesOffset5 = 0;
    new degreeOffset1 = 0;
    new motionSpeed = 180;
    if(degrees > 0)
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

    playSound(snd_beep);

    moveHead(direction, degrees + degreeOffset1);
    moveHead(direction, degreesOffset5);

    playSound(snd_beep);

    moveHead(direction, degrees);


    return checkObject(); 
}

walkForward() {
    playMotion(mot_walk, 1);
}
walkForwardHD() {
    playMotion(mot_walk_hd, 1);
}
walkForwardHU() {
    playMotion(mot_walk_hu, 1);
}

playMotion(motion, times)
    {
        for (new i=0; i<times; i++)
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
//direction is JOINT_NECK_VERTICAL or JOINT_NECK_HORIZONTAL
//degrees vertical: 90 to -90
//degrees horizontal: 50 to -50

joint_move_to(direction, degrees, 180, angle_degrees);

while(joint_is_moving(direction))
    {
    sleep;
    }
}

checkFront(){
    moveHead(JOINT_NECK_VERTICAL, -40);
    return checkObject();     
}

checkRight(){
    moveHead(JOINT_NECK_VERTICAL, -40);
    moveHead(JOINT_NECK_HORIZONTAL, 65);
    return checkObject();    
}

checkLeft(){
    moveHead(JOINT_NECK_VERTICAL, -40);
    moveHead(JOINT_NECK_HORIZONTAL, -65);
    return checkObject();    
}

checkObject(){
    new detection = sensor_get_value(SENSOR_OBJECT);
    if (detection >= 0 && detection < 20 ){
        playSound(snd_debug0);
    }
    else if(detection >=20 && detection < 40){
        playSound(snd_debug20);
    }
    else if(detection >=40 && detection < 60){
        playSound(snd_debug40);        
    }
    else if(detection >=60 && detection < 80){
        playSound(snd_debug60);        
    }
    else if(detection >=80 && detection < 100){
        playSound(snd_debug80);        
    }
    else{
        playSound(snd_debug100);
    }
    return detection;      
}

playSound(sound){
/*    if (sound == "liljon")
    {
        new choice = random(1);
        if (choice == 0)
        {
            sound = snd_yeah;
        } else if (choice == 1)
        {
            sound = snd_what;
        }
    }*/
    sound_play(sound);
    while(sound_is_playing(sound)){
        sleep;
    }
}

frontLeft() {
    playMotion(mot_com_walk_fl_2a, 1)
}

frontRight() {
    playMotion(mot_com_walk_fr_2a, 1)
}

frontLeftOneStep() {
    playMotion(mot_com_walk_fl_1step, 1);
}

frontRightOneStep() {
    playMotion(mot_com_walk_fr_1step, 1);
}

followRightEdge(){
    new frontDetect = checkFront();
    new rightDetect = checkRight();
    new leftDetect = checkLeft();

    if(frontDetect > 40 && rightDetect > 40 && leftDetect > 40){
        walkForward();    
    }
/*    else if (rightDetect < leftDetect){

    }
    else if(rightDetect > leftDetect)*/
}


findObject(){

    new previouslyFound = found;

    moveHead(JOINT_NECK_HORIZONTAL, 7);
 
    new front = moveHeadAndSense(JOINT_NECK_VERTICAL, 20);

    if(front > threshold)
    {
        found = 1;
        walkForwardHU();
    }
    else 
    {
        new right65 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);

        if (right65 > threshold)
        {
            found = 1;
            frontRightOneStep();
        }
        else
        {
            new right30 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 30);

            if (right30 > threshold)
            {
                found = 1;
                frontRightOneStep();
            }
            else
            {
                new left65 = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65);

                if (left65 > threshold)
                {
                    found = 1;
                    frontLeftOneStep();
                }
                else
                {
                    new left30 =moveHeadAndSense(JOINT_NECK_HORIZONTAL, -30);

                    if (left30 > threshold)
                    {
                        found = 1;
                        frontLeftOneStep();
                    }
                    else
                    {
                        found = 0;

                        if(previouslyFound)
                        {
                            targetCounter++;
                            playSound(snd_yeah);
                        }
                        else
                        {
                            walkForwardHU();  
                        }
                    }
                }
            }
        }
    }
}
