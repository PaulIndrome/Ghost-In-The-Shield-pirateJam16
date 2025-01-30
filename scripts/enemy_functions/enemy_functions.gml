///@self obj_enemy_base
function enemy_shove(_distance, _dir, _duration_s, _state = ENEMY_STATE.SHOVED, _height = 0){
	// SOUNDTODO shove
	
	enemy_state = _state;
	shove_duration_frames = _duration_s * game_get_speed(gamespeed_fps);
	shove_arc_height = _height;
	
	shove_start_x = x;
	shove_start_y = y;
	shove_end_x = x + lengthdir_x(_distance, _dir);
	shove_end_y = y + lengthdir_y(_distance, _dir);
	
	if(_state == ENEMY_STATE.SHOVED){
		sfx_play_simple([snd_metal_punch, snd_metal_punch_b]);
		sfx_play_simple([retro_impact_hit_04, retro_impact_hit_05, retro_impact_hit_06]);
		shove_count++;
	} else {
		sfx_play_simple([kick_soft_jab_impact_01, kick_soft_jab_impact_02]);
		sfx_play_simple([snd_retro_damage_hurt_ouch_20, snd_retro_damage_hurt_ouch_23]);
	}
	
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

///@self obj_enemy_base
function enemy_reset_speed(){
	enemy_state = ENEMY_STATE.WALK;
	speed = random_range(move_speed_base_min, move_speed_base_max);
	speed += shove_count * 0.2;
	image_speed = 1;
}

function enemy_reduce_speed(_factor){
	enemy_state = ENEMY_STATE.SLOWED;
	speed *= _factor;
	image_speed *= _factor;
}

///@self obj_enemy_base
function enemy_attack(_killing_blow){
	if(_killing_blow){
		with(obj_enemy_spawner){
			stop_spawn();
			current_flood = undefined;
		}
		
		with(obj_knight){
			// SOUNDTODO dead knight
			alarm_set(1, -1);
			knight_state = KNIGHT_STATE.DEAD;
			speed = 0;
		}
	
		//with(obj_shield){
		//	visible = false;
		//	x = 0;
		//	y = 0;
		//}
	
		var _self = id;
		with(obj_enemy_base){
			if(id == _self) continue;
		
			alarm_set(0, -1);
			enemy_reset_speed();
			enemy_reduce_speed(0.1);
		}
	}
	
	enemy_state = ENEMY_STATE.ATTACK;
	sprite_update();
	image_index = 0;
	speed = 0;
	layer_add_instance("Killer", id);
	
	switch(direction_quadrant()){
		case QUADRANT.RIGHT:
			x = obj_knight.x - sprite_width / 2;
			y = obj_knight.y;
			break;
		case QUADRANT.TOP:
			x = obj_knight.x;
			y = obj_knight.y + sprite_height / 2;
			break;
		case QUADRANT.LEFT:
			x = obj_knight.x + sprite_width / 2;
			y = obj_knight.y;
			break;
		case QUADRANT.BOTTOM:
			x = obj_knight.x;
			y = obj_knight.y - sprite_height / 2;
			break;
	}
}