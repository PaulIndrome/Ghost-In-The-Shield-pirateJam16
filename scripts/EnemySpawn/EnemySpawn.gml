global.floods = [];

array_push(global.floods, new EnemyFlood([
	new EnemyWave([
		new EnemyGroup(obj_demon_blue, 24, 0.25),
		new EnemyGroup(obj_demon_red, 8, 1),
	]) // wave
])); // flood 

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
	    if(current_wave >= array_length(waves)) return -1;
		
		if(waves[current_wave].spawn_done()){
		    current_wave++;
		}
		
		if(spawn_done()) return -1;
		
		return waves[current_wave].spawn();
	}
	
	static next_spawn_time = function(_current_time = get_timer_s()){
		if(spawn_done()) return -1;
		
		return waves[current_wave].next_spawn_time(_current_time);
	}
}

///@param {Array<Struct.EnemyGroup>} _groups groups
function EnemyWave(_groups) constructor {
    enemy_groups = _groups;
	current_group = 0;

	static spawn_done = function() { return current_group >= array_length(enemy_groups); }
	
	static spawn = function(){
		if(current_group >= array_length(enemy_groups)) return -1;
		
		if(enemy_groups[current_group].spawn_done()){
			current_group++;
		}
		
		if(spawn_done()) return -1;
		
		return enemy_groups[current_group].spawn();
	}
	
	static next_spawn_time = function(_current_time){
		if(spawn_done()) return -1;
		
		return enemy_groups[current_group].next_spawn_time(_current_time);
	}
}

function EnemyGroup(_obj, _count, _interval) constructor {
    spawn_object = _obj;
	spawn_count = _count;
	spawn_interval = _interval;
	
	count_spawned = 0
	
	static spawn_done = function() { return count_spawned >= spawn_count; }
	
	static spawn = function(){
	    if(count_spawned >= spawn_count) return -1;
		var _obj = spawn_object;
		
		with(obj_enemy_spawner){
		    spawn_enemy(_obj);
		}
		
		count_spawned++;
		
		var _time = get_timer_s();
		var _next_spawn_time = _time + spawn_interval;
		//show_debug_message($"count: {count_spawned} | next_spawn_time: {_next_spawn_time}");
		
		
		return _next_spawn_time;
	}
	
	static next_spawn_time = function(_current_time){
		if(spawn_done()) return -1;
		
		return _current_time + spawn_interval;
	}
}