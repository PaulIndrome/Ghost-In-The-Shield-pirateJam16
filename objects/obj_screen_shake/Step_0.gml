var _has_duration = shake_duration > 0;
if(_has_duration != layer_fx_is_enabled(layer_screen_shake)){
	layer_enable_fx(layer_screen_shake, _has_duration);
}

if(_has_duration){
	shake_duration -= DELTA_TIME_S;
}
