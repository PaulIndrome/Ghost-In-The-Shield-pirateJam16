enum MOD_OP {
	ADD, 
	MULT,
	SET,
}

enum MOD_CHANNEL {
	DIFFICULTY,
	UPGRADES,
	EFFECTS,
	OVERRIDES
}

///@ignore
function __create_modifier_channels_array(){
	var _arr = [];
	
	_arr[MOD_CHANNEL.DIFFICULTY] 	= 		new ModifierChannel("difficulty");
	_arr[MOD_CHANNEL.UPGRADES] 		= 		new ModifierChannel("upgrades");
	_arr[MOD_CHANNEL.EFFECTS] 		= 		new ModifierChannel("effects");
	_arr[MOD_CHANNEL.OVERRIDES] 	= 		new ModifierChannel("overrides");
	
	return _arr;
}

function Attribute(_name, _base_value) constructor{

	name = _name;
	attribute_base = _base_value;
	attribute_current = attribute_base;
	
	channels = __create_modifier_channels_array();
	
	last_update_frame = -1;
	
	static get = function(){
		return attribute_current;
	}
	
	///@param {Struct.ModifierBase} _modifier
	///@param {Constant.MOD_CHANNEL} _mod_channel
	static add_modifier = function(_modifier, _mod_channel){
		channels[_mod_channel].add_modifier(_modifier);
		__update();
	}
	
	///@param {Struct.ModifierBase} _modifier
	///@param {Constant.MOD_CHANNEL} _mod_channel
	static remove_modifier = function(_modifier, _mod_channel){
		channels[_mod_channel].remove_modifier(_modifier);
		__update();
	}
	
	///@param {Struct.ModifierBase} _modifier
	static remove_modifier_anywhere = function(_modifier){
		static holder = { modifier : undefined }
		holder.modifier = _modifier;
		
		array_foreach(channels, method(holder, function(_mod_channel){
			_mod_channel.remove_modifier(modifier);
		}));
		
		__update();
	}
	
	static remove_modifier_name = function(_name){
		static holder = { name : undefined }
		holder.name = _name;
		
		array_foreach(channels, method(holder, function(_mod_channel){
			_mod_channel.remove_modifier_name(name);
		}));
		
		__update();
	}
	
	///@ignore
	///@param {real} _prev result of previous modifier channel
	///@param {Struct.ModifierChannel} _next next modifier channel to apply to the last result
	static __reduce_func = function(_prev, _next){
		return _next.channel_modify(_prev);
	}
	
	///@ignore
	static __update = function(){
		attribute_current = array_reduce(channels, __reduce_func, attribute_base);
	}
}

function ModifierChannel(_name) constructor {
	
	name = _name;
	
	modifiers_inactive = [];
	modifiers_add = [];
	modifiers_mult = [];
	modifiers_set = [];
	
	modifier_result_add = 0;
	modifier_result_mult = 1.0;
	modifier_result_set = undefined;
	
	static channel_modify = function(_value){
		return modifier_result_set != undefined ? modifier_result_set : (_value + modifier_result_add) * modifier_result_mult;
	}
	
	///@param {Struct.ModifierBase} _modifier description
	static add_modifier = function(_modifier){
		if(is_instanceof(_modifier, ModifierBase) == false) return false;
			
		static identifier_struct = { name : "" };
		identifier_struct.name = _modifier.name;
		
		var _check = __get_op_array(_modifier.operation);
		
		if(array_any(_check, method(identifier_struct, function(_m){
			return _m.name == name;
		}))){ return -1; };
		
		array_push(_check, _modifier);
		
		update_modifier_result(_modifier.operation);
		
		return array_length(_check) - 1;
	}
	
	static remove_modifier = function(_modifier){
		if(is_instanceof(_modifier, ModifierBase) == false) return false;
	
		static identifier_struct = { name : "" };
		identifier_struct.name = _modifier.name;
		
		var _check = __get_op_array(_modifier.operation);
		
		var _index = array_find_index(_check, method(identifier_struct, function(_m){ return _m.name == name; }));
		if(_index < 0) return false;
			
		array_delete(_check, _index, 1);
		
		update_modifier_result(_modifier.operation);
		
		return true;
	}
	
	static remove_modifier_name = function(_name){
		for(var _i = array_length(modifiers_add) - 1; _i > -1; _i--){
			if(modifiers_add[_i].name != _name) continue;
				
			array_delete(modifiers_add, _i, 1); 
		}
		
		update_modifier_result(MOD_OP.ADD);
		
		for(var _i = array_length(modifiers_mult) - 1; _i > -1; _i--){
			if(modifiers_mult[_i].name != _name) continue;
				
			array_delete(modifiers_mult, _i, 1); 
		}
		
		update_modifier_result(MOD_OP.MULT);
		
		for(var _i = array_length(modifiers_set) - 1; _i > -1; _i--){
			if(modifiers_set[_i].name != _name) continue;
				
			array_delete(modifiers_set, _i, 1); 
		}
		
		update_modifier_result(MOD_OP.SET);
	}
	
	///@ignore
	static __get_op_array = function(_op){
		gml_pragma("forceinline");
		
		if(_op == MOD_OP.ADD){
			return modifiers_add;
		} else if(_op == MOD_OP.MULT){
			return modifiers_mult;
		} else {
			return modifiers_set;
		}
		
		//feather ignore once GM2047
		return undefined;
	}
	
	static update_modifier_result = function(_op){
		var _init = undefined;
		switch(_op){
			case MOD_OP.ADD:
				_init = 0;
				modifier_result_add = array_length(modifiers_add) > 0 ? array_reduce(modifiers_add, method(self, function(_prev, _next){ return _prev + _next.get(); }), array_first(modifiers_add).get()) : _init;
				break;
			case MOD_OP.MULT:
				_init = 1.0;
				modifier_result_mult = array_length(modifiers_mult) > 0 ? array_reduce(modifiers_mult, function(_prev, _next){ return _prev * (_next.get() - 1.0); }, array_first(modifiers_mult).get() - 1.0) + 1.0 : _init;
				break;
			case MOD_OP.SET:
				_init = undefined;
				modifier_result_set = array_length(modifiers_set) > 0 ? array_reduce(modifiers_set, function(_prev, _next){ return _prev == undefined ? _next.get() : max(_prev, _next.get()); }, array_first(modifiers_set).get()) : _init;
				break;
		}
	}
}

function ModifierBase(_name, _base_mod, _operation = MOD_OP.ADD) constructor {
	name = _name;
	modifier_base = _base_mod;
	modifier_current = modifier_base;
	operation = _operation;
	
	static get = function(_data){
		return modifier_current;
	}
}

function ModifierIncrement(_name, _base_mod, _mod_increment, _operation = MOD_OP.ADD) : ModifierBase (_name, _base_mod, _operation) constructor {
	
	is_curve = animcurve_exists(_mod_increment);
	modifier_increment = _mod_increment;
	
	character_data_hash = variable_get_hash("player_data")
	
	last_updated_level = -1;
	
	static get = function(_data){
		var _character_data = struct_get_from_hash(_data, character_data_hash);
		
		if(_character_data == undefined) return _value_prev;
		
		if(last_updated_level != _character_data.level){
			if(is_curve){
				modifier_current = animcurve_channel_evaluate(modifier_increment, _character_data.level_normalized);
			} else {
				modifier_current = modifier_increment * _character_data.level;
			}
		}
		
		return modifier_current;
	}
}