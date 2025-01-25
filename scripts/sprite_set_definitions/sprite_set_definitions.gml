global.sprite_sets = ds_map_create();

function _add_sprite_set(_keys, _set) {
	var _i = 0;
	var _arr = [];
	repeat(array_length(_set)){
		var _state = _set[@ _i][0];
		var _sprites = _set[@ _i][1];
		_add_state_directions(_arr, _state, _sprites);
		_i++;
	}
	
	var _k = 0;
	repeat(array_length(_keys)){
		ds_map_add(global.sprite_sets, _keys[_k++], _arr);
	}
}

function _add_state_directions(_arr, _state, _sprites){
	_arr[@ _state] = _sprites;
}

_add_sprite_set([obj_demon_blue, obj_demon_red], [
[ENEMY_STATE.WALK, [ Demon_walk_e, Demon_walk_n, Demon_walk_w, Demon_walk_s ] ], 
[ENEMY_STATE.ATTACK, [Demon_attack_e, Demon_attack_n, Demon_attack_w, Demon_attack_s] ],
[ENEMY_STATE.SHOVED, [Demon_hit_e, Demon_hit_n, Demon_hit_w, Demon_hit_s] ],
[ENEMY_STATE.BUMPED, [Demon_hit_e, Demon_hit_n, Demon_hit_w, Demon_hit_s] ],
]);
