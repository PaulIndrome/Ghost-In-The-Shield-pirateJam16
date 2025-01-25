shake_duration = 0;
layer_screen_shake = layer_get_id("screen_shake");

function screen_shake_add(_duration){
	shake_duration += shake_duration > _duration ? _duration / 2 : _duration;
}

layer_enable_fx(layer_screen_shake, false);