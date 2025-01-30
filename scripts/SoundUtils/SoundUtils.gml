///@param {Array<Asset.GMSound>, Asset.GMSound} _sound
///@param {real} _gain
function sfx_play_simple(_sound, _gain = 1, _pitch_offset = 0){
	if(is_array(_sound)){
		_sound = _sound[@ irandom(array_length(_sound) - 1)];
	}
	
	var _pitch = random_range(0.95, 1.15);
	audio_play_sound(
		_sound,
		1, 
		false,
		_gain,
		0,
		_pitch + _pitch_offset
	);
}