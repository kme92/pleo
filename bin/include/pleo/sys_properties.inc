//
// Pleo properties. PRIVATE version
//

enum property_name {
  property_none                =     0,
  property_min_sys             =     1,
  property_arousal             =     1, // property_min, python scripts can only handle numbers
  property_valence             =     2,
  property_stance              =     3,
  property_age                 =     4,
  property_damage              =     5,
  property_energy              =     6,
  property_health              =     7,
  property_mood                =     8,
  property_command             =     9,
  property_command_status      =    10,
  property_layer               =    11,
  property_probability         =    12,
  property_motion              =    13,
  property_command_pending     =    14,
  property_behavior_status     =    15,
  property_script_status       =    15, // property_behavior_status
  property_fatigue             =    16,
  property_direction           =    17,
  property_pose                =    18,
  property_sequence            =    19,
  property_platform            =    20,
  property_behavior            =    21,
  property_script              =    21, // property_behavior
  property_speed               =    22,
  property_neutral             =    23,
  property_pickedup            =    24,
  property_stand               =    25,
  property_liedown             =    26,
  property_trick_step          =    27,
  property_trick_id            =    28,
  property_sound               =    29,
  property_drive               =    30,
  property_motion_time         =    31,
  property_attn_track_weight   =    32, // attention system config property
  property_attn_hold_flags     =    33, // attention system config property
  property_cam_img_progress    =    34, // camera system property
  property_attn_track_mindist  =    35,
  property_attn_track_move     =    36,
  property_attn_p2p_timeout    =    37,
  property_max_sys,
// need this so it stays a 16 bit value...
  property_limit               =    65535
};


enum color_map_preset {
  color_map_none   = 0,
  color_map_red    = 1,
  color_map_green  = 2,
  color_map_blue   = 3,
  color_map_white  = 4,
  color_map_yellow = 5,
  color_map_auto   = 6,
  color_map_custom = 7,
  color_map_max
};


enum compare_name {
    compare_none,
    compare_equal,
    compare_not_equal,
    compare_less_than,
    compare_greater_than
};

enum config_name {
    config_access = -1,
    config_none,
    config_serial_is_usb,   /** return 1 if serial communication is happening over USB. 0 otherwise */
    config_monitor_echo,    /** Turn on or off monitor echo feedback */
    config_log_color,
    config_df_free,         /** how much free space on DF */
};

/**
 * @enum version_type
 * @brief this enumeration defines the different sources of version
 * information available. Used for the version_get call.
 */
enum version_name {
    version_none,
    version_serial,           /** Serial number of this Pleo */
    version_arm0,             /** Version of firmware in the body */
    version_arm1,             /** Version of firmware in the head */
    version_motor0,           /** Version of firmware running on motor controller 0 */
    version_motor1,           /** Version of firmware running on motor controller 1 */
    version_motor2,           /** Version of firmware running on motor controller 2 */
    version_motor3,           /** Version of firmware running on motor controller 3 */
    version_hardware,         /** Unique Hardware ID of this Pleo */
    version_board_id,         /** PCB revision ID of this Pleo */
    version_app_df,           /** Version of application stored in DataFlash, if any */
    version_app,              /** Version of currently executing application */
    version_boot,             /** Version of boot loader */
};
