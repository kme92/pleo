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

        sound_set_volume(100);
        goNeutralPosition();
        playSound(snd_stawded);

//check which side
        while(headSensor == 0){
            initialize();
            
//find first object
            while(headSensor == 0){
                findObjectTestNS();
                headSensor = sensor_get_value(SENSOR_HEAD);
            }
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

/*frontLeft() {
    motion_play(mot_com_walk_fl_2a);
    while (motion_is_playing(mot_com_walk_fl_2a)) {
        sleep;
    }
}*/

goNeutralPosition() {
    motion_play(mot_neutral);
    
    while (motion_is_playing(mot_neutral)) {
        sleep;
    }
}

initialize(){
/*    moveHead(JOINT_NECK_HORIZONTAL, 0);*/
/*    new front = moveHeadAndSense(JOINT_NECK_VERTICAL, -60);*/
    moveHead(JOINT_NECK_VERTICAL, -35);
    new right = moveHeadAndSense(JOINT_NECK_HORIZONTAL, 65);
    moveHead(JOINT_NECK_VERTICAL, -35);
    new left = moveHeadAndSense(JOINT_NECK_HORIZONTAL, -65);

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

    joint_move_to(direction, degrees - 5, 180, angle_degrees);

        while(joint_is_moving(direction))
        {
            sleep;
        }

    playSound(snd_beep);
    joint_move_to(direction, degrees, 180, angle_degrees);
        while(joint_is_moving(direction))
        {
            sleep;
        }

    return checkObject() 
}

walkForward() {
    motion_play(mot_walk);
    while (motion_is_playing(mot_walk))
            {
                sleep;
            }
}
walkForwardHD() {
    motion_play(mot_walk_hd);
    while (motion_is_playing(mot_walk_hd))
            {
                sleep;
            }
}
walkForwardHU() {
    motion_play(mot_walk_hu);
    while (motion_is_playing(mot_walk_hu))
            {
                sleep;
            }
}

walkForwardRight() {
    motion_play(mot_com_walk_fr_2a);
    while (motion_is_playing(mot_com_walk_fr_2a)) {
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
    moveHead(JOINT_NECK_HORIZONTAL, 0);
    moveHead(JOINT_NECK_VERTICAL, 15);
    new front = sensor_get_value(SENSOR_OBJECT);
    if(front > 20){
        while(front > 20){
            walkForwardHU();
            front = checkObject();
    }
    }
    else{
        moveHead(JOINT_NECK_HORIZONTAL, 40);
        new right = sensor_get_value(SENSOR_OBJECT);
        if(right > 20){
            frontRight();    
        }
        moveHead(JOINT_NECK_HORIZONTAL, -40);

        new left = sensor_get_value(SENSOR_OBJECT);
                if(left > 20){
            frontLeft();    
        }
    }
}

findObjectTestNS(){
    
    new threshold = 20;
    moveHead(JOINT_NECK_HORIZONTAL, 7);
    moveHead(JOINT_NECK_VERTICAL, 17);
    playSound(snd_beep);
    moveHead(JOINT_NECK_VERTICAL, 20);
    
    new front = checkObject();

    if(front > threshold){
        while(front > threshold){
            walkForwardHU();
            front = checkObject();
        }
    }
    moveHead(JOINT_NECK_HORIZONTAL, 55);
    playSound(snd_beep);
    moveHead(JOINT_NECK_HORIZONTAL, 60);
    new right = checkObject();

    if(right > threshold){
        frontRight();     
    }

    moveHead(JOINT_NECK_HORIZONTAL, -55);
    playSound(snd_beep);
    moveHead(JOINT_NECK_HORIZONTAL, -60);
    new left = checkObject();
        if(left > threshold){
        frontLeft() ;    
    }

    if(front < threshold && right < threshold && left < threshold){
        walkForwardHU();
        walkForwardHU();
    }
}