shader_type canvas_item;

uniform float radius : hint_range(0.0, 2.0) = 0.0;
uniform vec2 center = vec2(0.5, 0.5); // normalized screen center

void fragment() {
    vec2 uv = SCREEN_UV;
    float dist = distance(uv, center);
    if (dist < radius) {
        COLOR.a = 0.0; // Reveal new scene
    } else {
        COLOR.a = 1.0; // Cover old scene
    }
}
