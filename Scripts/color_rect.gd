shader_type canvas_item;

// Esta línea le dice a Godot: "Dame acceso a la imagen de la pantalla detrás de este objeto"
// y "prepárala para poder hacer zoom borroso (mipmaps)"
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// Un control deslizante para que elijas qué tan borroso lo quieres (0 a 5)
uniform float amount : hint_range(0.0, 5.0);

void fragment() {
	// Leemos la pantalla (screen_texture) en la posición de este pixel (SCREEN_UV).
	// El tercer parámetro 'amount' le dice qué nivel de detalle usar.
	// Un nivel alto (ej. 3.0 o 4.0) usa una versión reducida y borrosa de la imagen.
	vec4 color = textureLod(screen_texture, SCREEN_UV, amount);
	COLOR = color;
}
