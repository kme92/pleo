/* $Id$ */

/**
 * @file
 * Sequence System interface
 *
 * This file is marked private
 */
 
#if defined _sequence_included
  #endinput
#endif

#define _sequence_included

//prints the contents of the file to the monitor in table form
native sequence_print_file();
//prints the contents of the file to the monitor in tree form
native sequence_print_tree();

//will move to the child with sensor_id.
//if it doesn't exist, it will be added.
native sequence_move_next(sensor_id);
//just sees if a child with sensor_id exists, returns true/false
native sequence_peek_next(sensor_id);
//moves to the next node if it exists, if not, resets and retries. never adds
native sequence_check_next(sensor_id);
//resets the tree. also forces the file open and closed.
//call this whenever the chain is broken/interrupted/timed-out
native sequence_reset(bool: commit);
//set the action of the current node
native sequence_set_action(action_id);
//get the action of the current node
//-1 is no action (0 could be a valid action I guess)
native sequence_get_action();
//set the file to use for sequence data
native sequence_set_file(const string[]);