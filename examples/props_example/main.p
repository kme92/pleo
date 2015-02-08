//
// main.p
// Properties Example
//
// This very simple main script, which runs in the 
// Main VM, demonstrates the
// use of Pleo's properties system to communicate
// between scripts running in different VMs.
//
 
// save space by packing all strings
#pragma pack 1

// 
#include <Log.inc>
#include <Script.inc>
#include <Property.inc>
#include <Sound.inc>
#include <Motion.inc>

#include "user_properties.inc"
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

    // The main VM will run the main() function again and 
    // again once it returns, but this infinite for loop is
    // inserted to keep the main() function from returning.
    for (;;)
    {
    
        // If Pleo's head is being held, play a mooing noise
        // over and over again.
        while (property_get(property_head_held))
        {
            
            // Sounds are referred to by their filename,
            // minus the extension, with a prefix of "snd_".
            sound_play(snd_moo);
            
            // Wait for the sound to complete.
            while (sound_is_playing(snd_moo))
            {
                sleep;
            }
        
        }
        
        // If Pleo's head is tapped, play the bow motion
        if (property_get(property_head_tapped))
        {

            // Reset the head tapped property, to indicate
            // that we've taken action.
            property_set(property_head_tapped, 0);

            // Motions are referred to by their filename, minus
            // the extension, with a prefix of "mot_".
            motion_play(mot_kiss);
            
            // Wait for the sound to complete.
            while (motion_is_playing(mot_kiss))
            {
                sleep;
            }
            
        }
    
        // give some time back to the firmware
        sleep;
    }

}

public close()
{
    print("main:close() enter\n");

    print("main:close() exit\n");
}
