shader_type spatial;
render_mode unshaded;

uniform vec4 color : hint_color = vec4(1f);
uniform sampler2D noise : hint_albedo;

void fragment() {
	ALBEDO = color.rgb;
}
