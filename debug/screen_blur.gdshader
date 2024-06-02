shader_type canvas_item;

uniform vec2 mouse_pos = vec2(0.5);
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float blur_amount = 1;

uniform float frequency = 160;
uniform float depth = 0.01;

void fragment() {
	float x = mouse_pos.x;
	float y = mouse_pos.y;
	
	float spsx = SCREEN_PIXEL_SIZE.x;
	float ar = spsx/SCREEN_PIXEL_SIZE.y;
    vec2 normalized = vec2(SCREEN_UV.x, SCREEN_UV.y*ar);
    if (distance(vec2(x,y*ar), normalized) > 0.15) {
        vec2 uv = SCREEN_UV;
		uv.x += sin(uv.y * frequency + TIME) * depth;
		uv.x = clamp(uv.x, 0.0, 1.0);
		vec3 c = textureLod(screen_texture, uv, 0.0).rgb;

		COLOR.rgb = c;
    } else {
		COLOR.rgb = texture(screen_texture, SCREEN_UV).rgb;
	}
}

