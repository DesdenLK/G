#version 330 core


in vec2 vtexCoord;
out vec4 fragColor;

vec4 RED = vec4(1.0, 0.0, 0.0, 1.0);
vec4 WHITE = vec4(vec3(0.8),1);

uniform float n = 8;

void main()
{
    vec2 tex = vtexCoord*n;
    if (fract(tex.x) > 0.1 && fract(tex.y) > 0.1) discard;
    else fragColor = RED;
}
