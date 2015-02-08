/* $Id$ */

/**
 * @file
 * Drive System interface. This file is marked private.
 *
 */
 
#if defined _drive_included
  #endinput
#endif

#define _drive_included


native drive_add(const drive_name[], tvl, tvh, interval);

native emotion_add(const drive_name[], tvl, tvh, interval);

native behavior_add(behavior_id, const drive_name[], lead_time, upreg, samereg, downreg, interval);

native set_trigger_values(const drive_name[], tvl, tvh);

native behavior_set_value(const drive_name[], behavior_id, value);

native drive_set_value(const drive_name[], value);

/**
 * @brief load drives and behaviors from a file
 * @param filename to load from
 */
native bool: drive_load(const filename[]);

/**
 * @brief save drives and behaviors to a file
 * @param filename to save to
 */
native drive_save(const filename[]);

native drive_get_name(index, drivename[], length = sizeof drivename);
