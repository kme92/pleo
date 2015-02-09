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

new targetCounter = 0;

public init()
{
    print("main::init() enter\n");
   
    print("main::init() exit\n");
}

public main()
{
    print("main::main() enter\n");

//initialize
    while(true){
        new headSensor = sensor_get_value(SENSOR_HEAD);

        sound_set_volume(200);
        goNeutralPosition();
        playSound(snd_stawded);

//check which side
            initialize();
            
//find first object
            for(;;){
                if(targetCounter == 1)
                    {
                        new i = 0;
                        for(i=0;i<15; i++)
                            {
                                playMotion(mot_walk_hdr);
                            }
                    }
                findObject();
                headSensor = sensor_get_value(SENSOR_HEAD);
            }

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
    playMotion(mot_neutral);
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
    playMotion(mot_walk);
}
walkForwardHD() {
    playMotion(mot_walk_hd);
}
walkForwardHU() {
    playMotion(mot_walk_hu);
}

playMotion(motion)
    {
         motion_play(motion);
    while (motion_is_playing(motion))
            {
                sleep;
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
    sound_play(sound);
    while(sound_is_playing(sound)){
        sleep;
    }
}

frontLeft() {
    playMotion(mot_com_walk_fl_2a)
}

frontRight() {
    playMotion(mot_com_walk_fr_2a)
}

frontLeftOneStep() {
    playMotion(mot_com_walk_fl_1step);
}

frontRightOneStep() {
    playMotion(mot_com_walk_fr_1step);
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

    new found = 0;
    new threshold = 20;
    moveHead(JOINT_NECK_HORIZONTAL, 7);
 
    new front = moveHeadAndSense(JOINT_NECK_VERTICAL, 20);

    if(front > threshold){
        found = 1;
        while(front > threshold){
            walkForwardHU();
            front = checkObject();

        }

    }

    new right = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 60);

    if(right > threshold){
        found = 1;
        frontRightOneStep();     
    }
    
    new left = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -60);

    if(left > threshold){
        found = 1;
        frontLeftOneStep() ;    
    }

    if(!found){
        walkForwardHU();
    }
    else
        {
        targetCounter++;
        if(targetCounter == 2)
            {
            playMotion(mot_com_walk_bs);
            }
        }
}
