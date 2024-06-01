shader_type canvas_item;

uniform vec2 mouse_pos = vec2(0.5);

void fragment() {
	float x = mouse_pos.x;
	float y = mouse_pos.y;
	
	float spsx = SCREEN_PIXEL_SIZE.x;
	float ar = spsx/SCREEN_PIXEL_SIZE.y;
    vec2 normalized = vec2(SCREEN_UV.x, SCREEN_UV.y*ar);
    if (distance(vec2(x,y*ar), normalized) > 0.1) {
        discard;
    }
}

