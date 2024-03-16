#version 330 core


in vec2 vtexCoord;
out vec4 fragColor;

vec4 BLACK = vec4(0.0, 0.0, 0.0, 1.0);
vec4 WHITE = vec4(vec3(0.8),1);
uniform float n = 8;

void main()
{
    float x = int(mod(vtexCoord.x*n,2));
    float y = int(mod(vtexCoord.y*n,2));
    if (x == y) fragColor = WHITE;
    else fragColor = BLACK;
}
