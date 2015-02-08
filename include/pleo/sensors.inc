/*
 * Sensor names for Pleo. PRIVATE version
 */
enum sensor_name {

  SENSOR_NONE          =    -1,
  SENSOR_MIN           =     0,
  SENSOR_HIT	       =     0,
  SENSOR_NTC           =     1,
  
  SENSOR_BATTERY       =     2, // Battery level (0-100)
  SENSOR_IR            =     3, // IR data received
  SENSOR_IR_ACTIVITY   =     4, // IR has received a code of some kind (often, part of a beacon)
  SENSOR_RFID          =     5, // RFID objects

  SENSOR_TOUCH_FIRST   =     6, // Touch Sensors
  SENSOR_HEAD          =     6, // Head touch
  SENSOR_CHIN          =     7, // Chin touch
  
  SENSOR_CHEEKL        =     8, // Cheek Left
  SENSOR_CHEEKR        =     9, // Cheek Right
  
  SENSOR_BACK          =    10, // Neck1
  SENSOR_BACK2         =    11, // Neck2
  
  SENSOR_LEFT_LEG      =    12,
  SENSOR_RIGHT_LEG     =    13,
  SENSOR_LEFT_ARM      =    14,
  SENSOR_RIGHT_ARM     =    15,
  
  SENSOR_ARSE          =    16,	// Tail2
  SENSOR_TAIL          =    16,
  
  SENSOR_ARSE2         =    17,	// Tail2
  
  SENSOR_TOUCH_LAST    =    17,
  
  SENSOR_FOOT_FIRST    =    18, // Foot switches
  SENSOR_FRONT_LEFT    =    18,
  SENSOR_FRONT_RIGHT   =    19,
  SENSOR_BACK_LEFT     =    20,
  SENSOR_BACK_RIGHT    =    21,
  SENSOR_FOOT_LAST     =    21,

  SENSOR_CARD_DETECT   =    22, // SD Card is present
  
  SENSOR_ULTRA_SONIC   =    23, // Ultrasonic commands
  
  SENSOR_LIGHT         =    25, // Absolute light light (0-100)
  
  SENSOR_OBJECT        =    27, // Object in front of Pleo (reflected IR)
  SENSOR_MOUTH         =    28, // Something blocking mouth IR
  
  SENSOR_VR            =    29, // VR Module, return from head mcu recognized voice command value
  
  SENSOR_SOUND_DIR     =    30, // Where is the sound (0-4 now; perhaps degress wrt nose)
  SENSOR_LIGHT_CHANGE  =    31, // Light level change, lighten or darken
  SENSOR_SOUND_LOUD    =    32, // Absolute loudness of ambient sound (0-100)
  SENSOR_TILT          =    33, // Current orientation (see below)
  SENSOR_TERMINAL      =    34, // line of text from terminal/serial
  SENSOR_POWER_DETECT  =    35, // Is the charger plugged in?
  SENSOR_USB_DETECT    =    36, // Is the USB cable onnected
  SENSOR_WAKEUP        =    37, // Wakeup / Mom button
  SENSOR_BATTERY_TEMP  =    38, // Battery at critical temp?
  
  SENSOR_KEY_RTC       =    39, // noon button
  
  SENSOR_SHAKE         =    40, // Shake sensor activated
  SENSOR_SOUND_LOUD_CHANGE =41, // 1 = went above trig, 0 is went below aux_trig
  SENSOR_BEACON        =    42, // value = ID of other Pleo
  SENSOR_BATTERY_CURRENT =  43, // electrical current draw from battery
  SENSOR_PACKET        =    44, // virtual sensor to get the packet data from the NXP processor
  
  SENSOR_MAX		= 45,

  //derived sensors, here to share type sensor_t
  SENSOR_DERIVED_MIN         = 100, //start of derived sensors
  
  SENSOR_EDGE_IN_FRONT       = 101, //true / false (1 / 0)
  SENSOR_EDGE_ON_LEFT        = 102, //true / false
  SENSOR_EDGE_ON_RIGHT       = 103, //true / false
  SENSOR_OBJECT_IN_FRONT     = 104, //true / false
  SENSOR_OBJECT_ON_LEFT      = 105, //true / false
  SENSOR_OBJECT_ON_RIGHT     = 106, //true / false
  SENSOR_TOUCH_TAP           = 107, //sensor_id as value 
  SENSOR_TOUCH_HOLD          = 108, //sensor_id as value
  SENSOR_TOUCH_RELEASE       = 109, //sensor_id as value
  SENSOR_TOUCH_PETTED        = 110, //0 is not, 1 is back->arse, 2 is arse->back
  SENSOR_ABUSE               = 111, //true / false
  SENSOR_PICKED_UP           = 112, //height, in micrometers.... 
  SENSOR_TRACKABLE_OBJECT    = 113, //direction in degrees  
  SENSOR_FACE_DETECTION      = 114, //NO USE!!! //true / false
  SENSOR_ROCKING             = 115, //true / false
  				    //NO USE!!!
  SENSOR_LIGHT_BRIGHT_CHANGE = 117, //NO USE!!!
  SENSOR_ANTICIPATED_CUE     = 118, //NO USE!!!

  SENSOR_COLOR_CODE	     = 118, //card code card
  
  SENSOR_EDGE                = 119, //bundle  
  SENSOR_TOUCH_TAP_HOLD      = 120, //bundle
  SENSOR_SEQUENCE            = 121, //triggers when a sequence is hit
  SENSOR_JOINT_STUCK         = 122, //triggers when a joint is unable to move
  SENSOR_JOINT_UNSTUCK       = 123, //triggers when a joint is able to move again
  SENSOR_TIMER               = 124, //Virtual sensor used for timing
  SENSOR_MSG_RECEIVED        = 125, //a pleo changed its message
  SENSOR_MSG_GONE            = 126, //a pleo has left
  SENSOR_MILESTONE           = 127, //a milestone is triggered
  SENSOR_PLOG                = 128, //doesn't trigger, but can be disabled

  SENSOR_DERIVED_MAX		= 129
};

//the minimum priority a sensor helper needs to have to get a turn
//if we get really busy, the minimal_priority should rise.
//if a helper picks up something cool, its priority can rise  
enum derived_sensor_priority {
   D_SENSOR_PRIORITY_NONE    =  0,
   D_SENSOR_PRIORITY_MIN     =  1,
   D_SENSOR_PRIORITY_DEFAULT =  5,
   D_SENSOR_PRIORITY_MAX     = 10  
};

enum sound_loud_change_name  {
   SOUND_LOUD_CHANGE_NONE    =  0,
   SOUND_LOUD_CHANGE_MIN     =  1,
   SOUND_LOUD_CHANGE_LOW     =  1,
   SOUND_LOUD_CHANGE_NEUTRAL =  2,
   SOUND_LOUD_CHANGE_HIGH    =  3,
   SOUND_LOUD_CHANGE_MAX	= 4
};

enum light_bright_change_name  {
   LIGHT_BRIGHT_CHANGE_NONE    =  0,
   LIGHT_BRIGHT_CHANGE_MIN     =  1,
   LIGHT_BRIGHT_CHANGE_LOW     =  1,
   LIGHT_BRIGHT_CHANGE_NEUTRAL =  2,
   LIGHT_BRIGHT_CHANGE_HIGH    =  3,
   LIGHT_BRIGHT_CHANGE_MAX	= 4
};

enum tilt_name {
  TILT_NONE       =     0,
  TILT_MIN        =     1,
  TILT_ON_FEET    =     1,
  TILT_LEFT_SIDE  =     2,
  TILT_RIGHT_SIDE =     3,
  TILT_ON_NOSE    =     4,
  TILT_ON_TAIL    =     5,
  TILT_ON_BACK    =     6,
  TILT_MAX		= 7
};

enum drop_throw_swing_name {
  DROP_NONE       =     0,
  DROP_MIN        =     1,

  DROP_NORMAL     =     TILT_ON_FEET,
  DROP_LEFT       =     TILT_LEFT_SIDE,
  DROP_RIGHT      =     TILT_RIGHT_SIDE,

  G_THROWUP   	  =     4,
  G_SWING      	  =     5,

  MIC_HIT      	  =     6,	//hitting pleo's head or microphone

  DROP_MAX		= 7
};


enum petted_name  {
   PETTED_NONE            =  0,
   PETTED_MIN             =  1,
   PETTED_STOPPED         =  1,
   PETTED_BACKARSE        =  2,
   PETTED_ARSEBACK        =  3,
   PETTED_HEADBACK        =  4,
   PETTED_BACKHEAD        =  5,
   PETTED_HEADBACKARSE    =  6,
   PETTED_ARSEBACKHEAD    =  7,
   PETTED_BACK12	  =  8,
   PETTED_ARSE12       	  =  9,
   
   PETTED_MAX			= 10
};

enum packet_type {

	PACKET_NONE    = 0,
	PACKET_AUDIO   = 1,		// 1 <<  0, // 'a'
	PACKET_CAMERA  = 4,		// 1 <<  2, // 'c'
	PACKET_ECHO    = 16,		// 1 <<  4, // 'e'
	PACKET_IR      = 256,		// 1 <<  8, // 'i'
	PACKET_LOG     = 2048,		// 1 << 11, // 'l'
	PACKET_MOUTH   = 4096,		// 1 << 12, // 'm'
	PACKET_STAT    = 32768,		// 1 << 15, // 'p'
	PACKET_SRAM    = 262144,	// 1 << 18, // 's'
	PACKET_TOUCH   = 524288,	// 1 << 19, // 't'
	PACKET_VERSION = 2097152,	// 1 << 21, // 'v'
	PACKET_ERROR   = 8388608,	// 1 << 23, // 'x'
	PACKET_EXT     = 33554432,	// 1 << 25, // 'z'
	PACKET_ALL     = 2147483647	//0x7FFFFFFF
	
} ;

enum sensor_config {
    sensor_config_none,
    
    sensor_config_value = 1,            // sensor value. RO. Not Implemented
    sensor_config_raw_value = 2,        // sensor raw value. RO. Not Implemented
    sensor_config_enabled = 3,          // sensor is enabled? RW
    sensor_config_trigger = 4,          // sensor trigger level/value. RW
    sensor_config_aux_trigger = 5,      // sensor aux trigger level/value. RW
    sensor_config_trigger_last = 6,     // time since last sensor trigger. RO
    sensor_config_trigger_time = 7,     // time of last sensor trigger. RO
    sensor_config_trigger_count = 8,    // count of sensor triggers, in this play session. RO
    
    // sensor beacon
    sensor_config_beacon_id = 9,        // the beacon ID used for Pleo 2 Pleo comm. RW. Not Implemented
    
    // sensor timer
    sensor_config_timer_interval = 10,   // the duration of each timer event. RW
    
    // sensor packet
    sensor_config_packet_filter = 11,
};
