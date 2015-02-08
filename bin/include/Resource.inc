/* $Id$ */

/**
 * @file
 * Resource System interface
 *
 * Primitives provided by the Resource Manager
 *
 * Copyright (c) 2010,2011 Innvo Labs Life Forms
 */

#if defined _resource_included
  #endinput
#endif

#define _resource_included


enum resource_id {
    SOUND_BASE    = 0x1000,
    MOTION_BASE   = 0x2000,
    COMMAND_BASE  = 0x3000,
    SCRIPT_BASE   = 0x4000,
    PROPERTY_BASE = 0x5000
};

enum resource_type {
    res_sound,
    res_motion,
    res_command,
    res_script,
    res_property
};


/**
 * @brief given a resource name, get the matching ID. Resources include
 *        sounds, motions, commands, scripts and user properties
 * @param name of the resource
 * @return the ID of the resource if found. 0 otherwis
 */
native resource_get_id(const name[]);
    
/**
 * @brief given a resource ID, get the matching name. Resources include
 *        sounds, motions, commands, scripts and user properties
 * @param resource ID (sound_name, motion_name, etc.)
 * @param buffer to store the name of the resource
 * @param sizeof the buffer passed in, in cells
 * @return none (should this number of cells/characters copied?)
 */
native resource_get_name(id, name[], bool: packed = false, length = sizeof name);

/**
 * @brief function to validate resource file in DF. calculates the Adler32 checksum
 * of the data in DF, and compares to that stored within the DF.
 * @return boolean representing if the verification passed or failed. true if passed,
 * false is failed.
 */
native bool: resource_verify();

//jeff 110202, if you are running scripts at sd card, you need to use this function to check DF checksum
/**
 * @brief function to validate resource file in DF. calculates the Adler32 checksum
 * of the data in DF, and compares to that stored within the DF.
 * @return boolean representing if the verification passed or failed. true if passed,
 * false is failed.
 */
native bool: resource_verify_df();

/**
 * @brief function to get the version of any URF file
 * @param file_name to check for the version. ignored if override is non-0
 * @param override if set to version_app_df, version_app will return that version instead
 * @return integer value representing version tag of passed URF file
 */
native resource_file_get_version(const name[], override = 0);

//jeff 100828
/**
 * @brief function to verify data write to entire df resource area
 * and pm installed will be destroyed!
 * @return true or false
 */
native bool: resource_dftest();

//jeff 110127
/**
 * @brief function to validate resource file in DF with inputing the path of the urf in SD card
 * and compares the Adler32 checksum of the data in DF with the one in SD card.
 * pm installed will be destroyed!
 * @return true or false
 */
native bool: resource_verify_sdpm(const file_name[]);
