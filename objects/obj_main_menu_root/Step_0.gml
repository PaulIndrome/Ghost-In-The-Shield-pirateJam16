// Feather ignore GM1044

//var _using_gamepad = input_profile_get(0) == INPUT_AUTO_PROFILE_FOR_GAMEPAD;
//if(_using_gamepad != hide_cursor){
//	// hide cursor
//	hide_cursor = _using_gamepad;
//	window_set_cursor(hide_cursor ? cr_none : cr_default);
//}

// APPLY DESIRED METHOD TO FIND INPUT HERE
var _move = 0;
if(_move != 0){
	var _next_index = button_index_y_current;
	var _next_index_enabled = false;
	do{
		_next_index = ( (_next_index + _move) + array_length(root_buttons) ) % array_length(root_buttons);
		with(root_buttons[@ _next_index]){ _next_index_enabled = button_state != BUTTON_STATE.DISABLED; }
	} until(_next_index_enabled);
	
	with(button_current){
	    event_perform(ev_mouse, ev_mouse_leave);
	}
	with(root_buttons[@ _next_index]){
	    event_perform(ev_mouse, ev_mouse_enter);
	}
}

//if(input_check_pressed("accept")){
//    with(button_current){
//	    event_perform(ev_mouse, ev_left_press);
//	}
//}

//if(input_check_released("accept")){
//    with(button_current){
//	    event_perform(ev_mouse, ev_left_release);
//	}
//}

