if(enemy_state == ENEMY_STATE.WALK) {
    image_index = dir_sprite_offset() + (image_index % dir_sprite_mod());
}

//if(enemy_state == ENEMY_STATE.BUMPED) {
//    var _x = x + lengthdir_x(6, direction);
//	var _y = y + lengthdir_y(6, direction);

//	draw_line_color(x, y, _x, _y, image_blend, image_blend);
//}

draw_self();