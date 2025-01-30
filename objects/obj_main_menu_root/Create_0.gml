var _room_center_x = 160;
var _first_button_y = (room_height / 2);

root_buttons[0] = instance_create_layer(_room_center_x, _first_button_y, "Instances", obj_button_base);
//root_buttons[1] = instance_create_layer(_room_center_x, _first_button_y, "Instances", obj_button_base);
//root_buttons[2] = instance_create_layer(_room_center_x, _first_button_y, "Instances", obj_button_base);
//root_buttons[3] = instance_create_layer(_room_center_x, _first_button_y, "Instances", obj_button_base);

button_current = root_buttons[0];
button_previous = root_buttons[0];

button_index_x_current = 0;
button_index_y_current = 0;

hide_cursor = false; // can be set here with information about active input method if desired

///@param {Id.Instance} _button Button
function change_button_index(_button){
	if(_button.object_index != obj_button_base) exit;
	
	button_index_x_current = _button.button_index_x;
	button_index_y_current = _button.button_index_y;
	
	button_previous = button_current;
	button_current = _button;
	
	//show_debug_message($"Button with index {button_index_x_current}|{button_index_y_current} selected");
}

///@param {bool} _visible visible or not?
///@param {Array<real>} _indeces Indeces of buttons to toggle
function toggle_buttons(_visible, _indeces){
	if(is_array(_indeces) == false) exit;
	if(is_bool(_visible) == false) exit;
	
	var _i = 0;
    repeat(array_length(_indeces)){
		var _idx = _indeces[@ _i];
		if(_idx < 0 || _idx > array_length(root_buttons) - 1) continue;
		root_buttons[@ _indeces[_i]].visible = _visible;
	    _i++;
	}
}

with(root_buttons[@ 0]){
    button_text = "play";
	button_index_x = 0;
	button_index_y = 0;
	
	array_push(button_on_click, function(){
		button_stalled = true;
		obj_main_menu_root.toggle_buttons(false, [1, 2, 3]);
		
		cursor_sprite = cr_none;
		window_set_cursor(cr_none);
		
		call_later(0.5, time_source_units_seconds, function(){ button_stalled = false; room_goto(rm_game); }); 
	});
	
	array_push(button_on_hover, function(){ obj_main_menu_root.change_button_index(id); });
}

//with(root_buttons[1]){
//    button_text = "Settings";
//	button_index_x = 0;
//	button_index_y = 1;
//	button_state = BUTTON_STATE.DISABLED;
	
//	array_push(button_on_click, function(){ show_debug_message("No settings menu available."); }); // activate settings object
//	array_push(button_on_hover, function(){ obj_main_menu_root.change_button_index(id); });
//	y += sprite_height * 1.33;
//}

//with(root_buttons[2]){
//    button_text = "Help";
//	button_index_x = 0;
//	button_index_y = 2;
//	button_state = BUTTON_STATE.DISABLED;
	
//	array_push(button_on_hover, function(){ obj_main_menu_root.change_button_index(id); });
	
//	y += sprite_height * 1.33 * 2;
//}

//with(root_buttons[3]){
//    button_text = "Quit";
//	button_index_x = 0;
//	button_index_y = 3;
	
//	array_push(button_on_click, function(){ 
//		button_stalled = true;
//		obj_main_menu_root.toggle_buttons(false, [0, 1, 2]);
//		call_later(1, time_source_units_seconds, function(){ button_stalled = false; game_end(0); }); 
//	});
	
//	array_push(button_on_hover, function(){ obj_main_menu_root.change_button_index(id); });
//	y += sprite_height * 1.33 * 3.66;
//}
