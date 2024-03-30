#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform vec2 origin = vec2(0,0);
uniform int nstripes = 16;

vec4 YELLOW = vec4(1,1,0,1);
vec4 RED = vec4(1,0,0,1);

void main()
{
    vec2 tex = vtexCoord*nstripes;
    float distance = distance(nstripes * origin, tex);
    if (int(distance) % 2 == 0) fragColor = RED;
    else fragColor = YELLOW;
}
