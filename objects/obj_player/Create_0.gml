control_dir = 0;

move_speed_current = new Attribute("move_speed", move_speed_default);
var _modifier = new ModifierBase("test", 2, MOD_OP.MULT);
move_speed_current.add_modifier(_modifier, MOD_CHANNEL.EFFECTS);