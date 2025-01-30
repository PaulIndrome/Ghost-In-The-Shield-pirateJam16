function button_on_hover_default(){
	// default on hover function
}

function button_on_click_default(){
	sfx_play_simple(squeaky_rubber_toy_cartoon_03, 0.5);
}

fnt_main_menu = fnt_harrington;

button_stalled = false;

button_state = BUTTON_STATE.NORMAL;
button_index_y = -1;
button_index_x = -1;

button_actions_map = ds_map_create();

button_on_click = array_create(0, undefined);
button_on_hover = array_create(0, undefined);
button_on_unhover = array_create(0, undefined);

ds_map_add(button_actions_map, BUTTON_STATE.CLICKED, button_on_click);
ds_map_add(button_actions_map, BUTTON_STATE.HOVERED, button_on_hover);
ds_map_add(button_actions_map, BUTTON_STATE.NORMAL, button_on_unhover);

array_push(button_on_hover, button_on_hover_default);
array_push(button_on_click, button_on_click_default);

///@param {real} _action BUTTON_ACTION to look up the function array in the actions map for
function button_call_functions(_action /*, _new_state = _action */){
	if(button_state == BUTTON_STATE.DISABLED && _action != BUTTON_STATE.ENABLE) exit;
	if(button_stalled && _action = BUTTON_STATE.CLICKED) exit;
	
	button_state = _action;
	
	if(ds_map_exists(button_actions_map, _action) == false) exit;
	
	var _arr_func = button_actions_map[? _action];
	if(is_array(_arr_func) == false) exit;
	
    var _i = 0;
	repeat(array_length(_arr_func)){
		_arr_func[@ _i]();
	    _i++;
	}
}