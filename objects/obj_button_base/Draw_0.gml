var _text_color = c_grey;
switch (button_state) {
    case BUTTON_STATE.HOVERED:
        sprite_index = spr_btn_hovered;
		_text_color = c_white;
        break;
	case BUTTON_STATE.MOUSE_DOWN:
        sprite_index = spr_btn_mousedown;
		_text_color = c_white;
        break;
	case BUTTON_STATE.DISABLED:
		sprite_index = spr_btn_disabled;
		_text_color = c_dkgray;
		break;
    default:
        sprite_index = spr_btn_normal;
        break;
}

draw_self();

//draw_set_font(fnt_main_menu);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(_text_color);

draw_text(x, y, button_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1.0);