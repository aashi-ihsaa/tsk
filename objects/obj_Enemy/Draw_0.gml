/// @description Insert description here
// You can write your code in this editor
depth = -y


draw_self()
draw_path(UltraPath,x,y,true)

draw_set_color(debug_draw_color)

DrawSightCone()

draw_set_color(debug_draw_color)

draw_circle(TargetX,TargetY,8,true)
draw_circle(Target.x,Target.y,6,true)

//draw_set_color(c_lime)
draw_set_color(debug_draw_color)
draw_line(x,y,obj_Player.x,obj_Player.y)

draw_set_color(debug_draw_color)
var LDX = lengthdir_x(Speed_Move,SightDirectionCurrent);
var LDY = lengthdir_y(Speed_Move,SightDirectionCurrent);
draw_text(x,y+16,"LDX: " + string(LDX) + "\nLDY: " + string(LDY))

if Angry > 0 {
	draw_sprite_ext(spr_progressbar,0,x-sprite_get_width(plhd_enemy_run)/2,y-sprite_get_height(plhd_enemy_run)-6,1,1,0,c_white,1)
	draw_sprite_ext(spr_progressbar,1,x-sprite_get_width(plhd_enemy_run)/2,y-sprite_get_height(plhd_enemy_run)-6,Angry/300,1,0,c_white,1)
	draw_sprite_ext(spr_progressbar,0,x-sprite_get_width(plhd_enemy_run)/2,y-sprite_get_height(plhd_enemy_run),1,1,0,c_white,1)
	draw_sprite_ext(spr_progressbar,1,x-sprite_get_width(plhd_enemy_run)/2,y-sprite_get_height(plhd_enemy_run),MeleeCD/MeleeCDReset,1,0,c_red,1)
}