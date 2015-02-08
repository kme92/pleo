/* $Id$ */

/**
 * @file
 * Camera interface
 *
 * Interface to the Camera system of this life form.
 * 
 *
 */

#if defined _camera_included
  #endinput
#endif

#define _camera_included

//must be the same in hl_attention.c
// (should be in a shared include)
#define FOV_H_DEG 50
#define FOV_V_DEG 40

 /** @brief set the camera colormap
 *
 *  sets an entry in the color map
 *  @param entry 0-7, the entry to set
 *  @param  rhi high for the red   channel
 *  @param  rlo low  for the red   channel 
 *  @param  ghi high for the green channel
 *  @param  glo low  for the green channel 
 *  @param  bhi high for the blue  channel 
 *  @param  blo low  for the blue  channel
 *  @return void
 */
native void: camera_set_colormap(entry, rhi, rlo, ghi, glo, bhi, blo);

native void: camera_track_enable(bool: enable);

native void: camera_set_color_preset(color_map_preset: preset);

//native bool: camera_get_object(&cm, &x1, &y1, &x2, &y2);
//not sure how to specify "type" and "by ref", the above doesn't compile 
native bool: camera_get_object(&cm, &x1, &y1, &x2, &y2);

/** @brief requests camera average for a given window
 *  @param x1 window upper left x 
 *  @param y1 window upper left y
 *  @param x2 window lower right x
 *  @param y2 window lower right y
 */ 
native void: camera_request_average(x1, y1, x2, y2);

/** @brief receives camera average for a given window
 *         needs to be called within a second after a request
 *         to succeed. will also fail while the camera has not 
 *         yet responded to the request
 *  @param &y_b receiving Y or G average
 *  @param &u_g receiving U or B average
 *  @param &v_r receiving V or R average
 *  @return success 
 */ 
native bool: camera_get_average(&y_g, &u_b, &v_r);

//enables / disables the camera
native void: camera_enable(bool: enable);

//sets a register to the specified value
native void: camera_set_register(reg, val);

/** @brief takes a picture
 *  @param filename to store it in
 *  @return valid filename length or not
 */ 
native bool: camera_take_picture(const file_name[]);