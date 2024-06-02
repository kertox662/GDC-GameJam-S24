shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float ar = 16.0/9.0;
	COLOR.rgb = SCREEN_UV.xxy;
	vec2 normalized = vec2(SCREEN_UV.x*ar, SCREEN_UV.y);
	if (distance(vec2(0.5*ar,0.5), normalized) > 0.1) {
		discard;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
