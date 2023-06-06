/// @description No Draw
depth = -y


var LDX = lengthdir_x(1,point_direction(x,y,mouse_x,mouse_y));
var LDY = lengthdir_y(1,point_direction(x,y,mouse_x,mouse_y));
draw_text(x,y+16,"LDX: " + string(LDX) + "\nLDY: " + string(LDY))



