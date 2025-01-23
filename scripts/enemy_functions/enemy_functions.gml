///@self obj_enemy_base
function enemy_shove(_distance, _dir, _duration_s, _state = ENEMY_STATE.SHOVED, _height = 0){
	enemy_state = _state;
	shove_duration_frames = _duration_s * game_get_speed(gamespeed_fps);
	shove_arc_height = _height;
	
	shove_start_x = x;
	shove_start_y = y;
	shove_end_x = x + lengthdir_x(_distance, _dir);
	shove_end_y = y + lengthdir_y(_distance, _dir);
	
	alarm[0] = shove_duration_frames;
	direction = _dir;
	speed = 0;
}

global.enemy_state_grid = [	
						/*request 	ENEMY_STATE.IDLE,	ENEMY_STATE.WALK,	ENEMY_STATE.SHOVED,	ENEMY_STATE.BUMPED,	ENEMY_STATE.DYING,	ENEMY_STATE.DEAD */
/* current */ 
/* ENEMY_STATE.IDLE	*/				[false,				false,				false,				true,				false,				false,],
/* ENEMY_STATE.WALK	*/				[false,				false,				false,				true,				false,				false,],
/* ENEMY_STATE.SHOVED */			[false,				false,				false,				false,				false,				false,],
/* ENEMY_STATE.BUMPED	*/			[false,				false,				false,				false,				false,				false,],
/* ENEMY_STATE.DYING */				[false,				false,				false,				false,				false,				false,],
/* ENEMY_STATE.DEAD	*/				[false,				false,				false,				false,				false,				false,],
];

global.enemy_state_map = ds_map_create();

///@self obj_enemy_base
function enemy_can_enter_state(_state){
    return global.enemy_state_grid[@ enemy_state][@ _state];
}