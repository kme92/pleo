/* $Id$ */

/**
 * @file
 * Time interface
 *
 * Misc. time functions
 *
 * Copyright (c) 2010,2011 Innvo Labs Life Forms
 */

#if defined _time_included
  #endinput
#endif

#define _time_included


/**
 * @brief return the current time
 * @return the time in milliseconds since the life form was powered on
 */
native time();

//jeff 100424
/**
 * @brief sets real time time data
 * @param string buffer specifying the date and time string, format is yyyymmddhhmm
 * @return N/A
 */
native time_set(data[]);

/**
 * @brief gets real time time data
 * @param string buffer storing the date and time string, format is yyyymmddhhmm
 * @return N/A
 */
native time_get(data[]);

//jeff 100827
/**
 * @brief gets real time second data
 * @param string buffer storing the second string, format is ss
 * @return N/A
 */
native time_second_get(data[]);
