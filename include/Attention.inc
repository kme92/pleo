/* $Id$ */

/**
 * @file
 * Attention System interface
 *
 * This file is marked private
 */
 
#if defined _attention_included
  #endinput
#endif

#define _attention_included

// Attention System functions


/**
 * @brief updates the relation between a step and a motion 
 *        for [c], you'll call this at [j] or [h]
 * @param trick_id
 * @param step
 * @param motion_id
 * @param value
 * @return previous value 
 */
native set_reward(trick_id, step, motion_id, value);

/**
 * @brief returns the last recorded step for a trick
 *        you will use this information in [e] and [k]
 * @param int trick_id
 * @return the last recorded step 
 */
native get_last_step(trick_id);

/**
 * @brief this updates the relation between a step and cmd, 
 *        for [p], you call this at  [m]
 * @param trick_id
 * @param step
 * @param cmd_id
 * @return
 */
native set_trick_step(trick_id, step, cmd_id);


/**
 * @brief returns the cmd_id for this trick_id and step
 *        you call this at [p]. I updated the attached graph to give [p] a better description.
 * @param trick_id
 * @param step
 * @return
 */
native get_trick_cmd(trick_id, step);

/**
 * @brief prints the current state of the trick table
 * @param none
 * @return 0
 */
native print_links();

/**
 * @brief set the parameters for ambient sound sensor
 * @param factor
 * @param trigger
 * @return 0
 */
native set_ambient_sound_parms(factor, trigger);

/**
 * @brief get the current ambient sound level
 * @param none
 * @return the current ambient sound level
 */
native get_ambient_sound_level();

/**
 * @brief set the ambient light sensor parameters
 * @param factor
 * @param trigger
 * @return 0
 */
native set_ambient_light_parms(factor, trigger);

/**
 * @brief return the current ambient sound level
 * @param  none
 * @return the current ambient sound level
 */
native get_ambient_light_level();

/**
 * @brief 
 * @param 
 * @return
 */
native set_derived_sensor_priority(sensor_name: sensor_id, priority);

/**
 * @brief 
 * @param 
 * @return
 */
native inc_derived_sensor_priority(sensor_name: sensor_id);

/**
 * @brief 
 * @param 
 * @return
 */
native dec_derived_sensor_priority(sensor_name: sensor_id);

/**
 * @brief 
 * @param 
 * @return
 */
native tricks_load_data(const file_name[]);

/**
 * @brief 
 * @param 
 * @return
 */
native tricks_save_data(const file_name[]);

/**
 * @brief 
 * @param 
 * @return
 */
native set_joint_stuck_limit(limit);

/**
 * @brief sets the timer interval
 * @param the interval to set in milliseconds, use 0 to disable
 * @return previous interval
 */
native set_timer_interval(interval);

/**
 * @brief sets the parameters for object and edge detection
   @param  object_nv_lo_limit:  Minimum Neck Vertical angle for Object detection to occur, default = 0
   @param  edge_nv_hi_limit:    Maximum Neck Vertical angle for Edge detection to occur, default = -40 degrees 
   @param  object_ir_hi_limit:  high limit for object ir reflection. if it goes over  this, object goes on, default 40
   @param  object_ir_lo_limit:  low  limit for object ir reflection. if it goes under this, object goes off, default 20
   @param  edge_ir_hi_limit:    high limit for edge ir reflection.   if it goes over  this, edge   goes off, default 40
   @param  edge_ir_lo_limit:    low  limit for edge ir reflection.   if it goes under this, edge   goes on, default 20
   @param  object_linger:       minimum time(ms) neck v needs to be above object_nv_low_limit for object to trigger default 500ms
   @param  edge_linger:         minimum time(ms) neck v needs to be below edge_nv_hi_limit for object to trigger default 500ms
 * @return void
 */
native void: set_object_edge_parms(
                           object_nv_lo_limit,
                           edge_nv_hi_limit,
                           object_ir_lo_limit,
                           object_ir_hi_limit,
                           edge_ir_lo_limit,
                           edge_ir_hi_limit,
                           object_linger,
                           edge_linger);


/**
 * @brief reset the message slot from one sender
   @param sender id or negative for all
 * @return success
 */
native bool: p2p_reset(from);

/**
 * @brief stops the sending of pleo2pleo messages
 * @return success
 */
native bool: p2p_stop_msg();

/**
 * @brief sets the pleo2pleo message
   @param recipient: who should get this
   @param data1: data byte 1
   @param data2: data byte 2
   @param broadcast: is this a broadcasted message (if yes recipient is ignored)
 * @return success
 */
native bool: p2p_set_msg(recipient, data1, data2, broadcast);

/**
 * @brief gets the pleo2pleo message for a specific sender
   @param from: whose message do you want?
   @param data1: received data byte 1
   @param data2: received data byte 2
   @param broadcast: was this a broadcasted message ?
   @param repeat_count: how manieth copy of this message did we get?
   @param repeat_count: how many messages did this sender send us in total during this encounter
 * @return success
 */
native bool: p2p_get_msg(from, &data1, &data2, &broadcast, &repeat_count, &total_count);

/**
 * @brief gets the pleo2pleo id for this pleo
 * @return the pleo2pleo id
 */
native p2p_get_id();


/**
 * @brief sets the property to use for milestones
 * @param property_name
 * @return success
 */
native bool: mls_set_property(property_t: property_name);

/**
 * @brief sets the filename to use for milestones
 * @param file name
 * @return success
 */
native bool: mls_set_file_name(const file_name[]);

/**
 * @brief sets a new milestone. it must be higher than the last one
 * @param the property value at which the milestone occurs
 * @param the action to be taken on this milestone (usually a command, motion, sound id)
 * @param whether or not this is the last one to be added in a row (close file / commit data)
 * @return success
 */
native bool: mls_set(milestone, milestone_action, bool: close_file);
