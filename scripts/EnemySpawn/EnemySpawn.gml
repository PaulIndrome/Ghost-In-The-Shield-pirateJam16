///@param {Asset.GMObject} _obj
function spawn_enemy(_obj){
	var _random_dir = choose(random_range(-60, 60), random_range(120, 240));
	var _x_offset = lengthdir_x(room_width * 0.5, _random_dir);
	var _y_offset = lengthdir_y(room_height, _random_dir);
	
	instance_create_layer(room_mid_x() + _x_offset, room_mid_y() + _y_offset, "Instances", _obj);
}

///@param {Array<Struct.EnemyWave>} _waves
function EnemyFlood(_waves) constructor {
	waves = _waves;
	current_wave = 0;
	
	remaining = 0;
	
	static reset = function(){
	    var _w = 0;
		repeat(array_length(waves)){
			var _g = 0;
			repeat(array_length(waves[_w].enemy_groups)){
				remaining += waves[_w].enemy_groups[_g].spawn_count;
				
				waves[_w].enemy_groups[_g].count_spawned = 0;
				
				_g++;
			}
			
			waves[_w].current_group = 0;
			
		    _w++;
		}
		
		current_wave = 0;
	}
	
	static spawn_done = function(){ return current_wave >= array_length(waves); }
	
	static spawn = function(){
		// attempt to spawn something in the current wave
		var _time = waves[current_wave].spawn();
		
		// if current wave is giving a negative time for the next run through, go to next wave and try again
		if(_time < 0){
		    current_wave++;
		}
		
		// if current wave marks flood as done, stop spawning
		var _flood_done = spawn_done();
		if(_flood_done) return -1;
		
		// otherwise attempt a spawn in next wave
		return _time < 0 ? waves[current_wave].spawn() : _time;
	}
	
	static next_spawn_time = function(_current_time = get_timer_s()){
		if(spawn_done()) return -1;
		
		return waves[current_wave].next_spawn_time(_current_time);
	}
	
	static add_enemy = function(_obj, _count, _wave, _interval){
		//show_debug_message($"adding {_count}x {object_get_name(_obj)} to wave {_wave}");
		if(_wave >= array_length(waves)) exit;
		
		_wave = waves[@ _wave];
		var _group_index = _wave.find_group(_obj);
		
		if(_group_index < 0){
			array_push(_wave.enemy_groups, new EnemyGroup(_obj, _count, _interval));
		} else {
			_wave.enemy_groups[@ _group_index].spawn_count += _count;
		}
	}

}

///@param {Array<Struct.EnemyGroup>} _groups groups
function EnemyWave(_groups) constructor {
    enemy_groups = _groups;
	current_group = 0;

	static spawn_done = function() { return current_group >= array_length(enemy_groups); }
	
	static spawn = function(){
		var _group_done = enemy_groups[current_group].spawn_done();
		if(_group_done){
			current_group++;
		}
		
		var _wave_done = spawn_done();
		if(_wave_done) {
			with(obj_enemy_spawner){
				wave_count++;
			}
			
			return -1;
		}
		
		var _time = enemy_groups[current_group].spawn();
		
		return _time;
	}
	
	static next_spawn_time = function(_current_time){
		if(spawn_done()) return -1;
		
		return enemy_groups[current_group].next_spawn_time(_current_time);
	}
	
	static find_group = function(_obj){
		var _g = 0;
		repeat(array_length(enemy_groups)){
			if(enemy_groups[@ _g].spawn_object == _obj) return _g;
			_g++;
		}
		
		return -1;
	}
}

function EnemyGroup(_obj, _count, _interval) constructor {
    spawn_object = _obj;
	spawn_count = _count;
	spawn_interval = _interval;
	
	count_spawned = 0
	
	static spawn_done = function() { return count_spawned >= spawn_count; }
	
	static spawn = function(){
		var _count_done = spawn_done();
		if(_count_done) return -1;
		
		var _obj = spawn_object;
		
		spawn_enemy(_obj);
		
		count_spawned++;
		
		var _time = get_timer_s();
		var _next_spawn_time = _time + spawn_interval;
		return _next_spawn_time;
	}
	
	static next_spawn_time = function(_current_time){
		if(spawn_done()) return -1;
		
		return _current_time + spawn_interval;
	}
}