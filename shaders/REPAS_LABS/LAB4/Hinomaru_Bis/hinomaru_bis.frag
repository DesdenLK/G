#version 330 core

in vec4 frontColor;
out vec4 fragColor;

vec2 centre = vec2(0.5, 0.5);
float radius = 0.2;
in vec2 vtexCoord;

vec4 RED = vec4(1, 0, 0, 1);
vec4 WHITE = vec4(1,1,1,1);

void main()
{
    float distance = distance(vtexCoord, centre);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    if (smoothstep(radius - w, radius + w, distance) == 0) fragColor = RED;
    else fragColor = WHITE;
}
