enum MOD_OP {
	ADD, 
	MULT,
	SET,
}

function Attribute(_name, _base_value) constructor{

	name = _name;
	attribute_base = _base_value;
	attribute_current = attribute_base;
	
	channels = []; // modifiers
	
	static get = function(){}
	
	static add_modifier = function(){}
	
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
				_init = array_contains
				modifier_result_add =  ? array_reduce(modifiers_add, method(self, function(_prev, _next){ 
					return _prev + _next.modifier_current; 
				}), array_first(modifiers_add).modifier_current) : _init;
				break;
			case MOD_OP.MULT:
				_init = 1.0;
				modifier_result_mult = array_length(modifiers_mult) > 0 ? array_reduce(modifiers_mult, function(_prev, _next){ return _prev + (_next.modifier_current - 1.0); }, array_first(modifiers_mult) - 1.0) + 1.0 : _init;
				break;
			case MOD_OP.SET:
				modifier_result_set = array_length(modifiers_set) > 0 ? array_reduce(modifiers_set, function(_prev, _next){ return max(_prev.modifier_current, _next.modifier_current); }) : _init;
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

function ModifierIncrement(_name, _base_mod, _mod_increment, _operation = MOD_OP.ADD) : ModifierBase (_name, _base_mod, _operation){
	
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