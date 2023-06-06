/// @description App Window
gpu_set_blendenable(false)
var scl = window_get_width()/CamWidth;
draw_surface_ext(application_surface, 0 - (frac(x)*scl), 0 - (frac(y)*scl), scl, scl, 0, c_white, 1.0)
gpu_set_blendenable(true)