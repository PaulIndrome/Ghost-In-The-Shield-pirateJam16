/*
enum DIRECTION {
    RIGHT	= 0,
    DOWN	= 1,
    LEFT	= 2,
    UP		= 3,
}

global.sprite_map = ds_map_create();
global.sprite_map[? obj_demon_red] = [spr_demon_walk_right, spr_demon_walk_down, spr_demon_walk_left, spr_demon_walk_up];
global.sprite_map[? obj_demon_blue] = [spr_demon_walk_right, spr_demon_walk_down, spr_demon_walk_left, spr_demon_walk_up];

///@self obj_enemy_base
///@param {real} _dir
function sprite_direction(_dir){
    if(is_int64(_dir) == false) return spr_invalid;
	if(ds_map_exists(global.sprite_map, object_index) == false) return spr_invalid;
	
	return global.sprite_map[? object_index][_dir];
}
*/

//function SpriteFrames(_down, _left, _right, _up) constructor {
//    down = _down;
//    left = _left;
//	right = _right;
//    up = _up;
//}

//global.sprite_frames = ds_map_create();

//global.sprite_frames[? Demon_walk] = new SpriteFrames([0, 3], [4, 7], [8, 11], [12, 15]);
//global.sprite_frames[? Demon_idle] = new SpriteFrames([0, 3], [4, 7], [8, 11], [12, 15]);
//global.sprite_frames[? Demon_hit] = new SpriteFrames([0, 1], [2, 3], [4, 5], [6, 7]);

enum DIR_OFFSET_INDEX {
    DOWN = 0,
	LEFT = 4,
	RIGHT = 8,
	UP = 12,
}
