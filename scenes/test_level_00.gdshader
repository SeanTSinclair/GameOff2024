shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Treat black as transparent
    if (tex_color.rgb == vec3(0.0)) {
        discard;  // Discard black pixels
    }

    COLOR = tex_color;
}