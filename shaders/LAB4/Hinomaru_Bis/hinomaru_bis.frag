#version 330 core


in vec2 vtexCoord;
out vec4 fragColor;

vec4 RED = vec4(1.0, 0.0, 0.0, 1.0);
vec4 WHITE = vec4(vec3(1.0, 1.0, 1.0),1);
uniform float n = 8;

const vec2 centre = vec2(0.5, 0.5);

void main()
{
    float distance = distance(centre, vtexCoord);
    float w = length(vec2(dFdx(distance),dFdy(distance)));
    if (smoothstep(0.2 - w, 0.2 + w, distance) == 0) fragColor = RED;
    else fragColor = WHITE;
}

