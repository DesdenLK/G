#version 330 core

in vec4 frontColor;
out vec4 fragColor;

vec2 centre = vec2(0.5, 0.5);
float radius = 0.2;
in vec2 vtexCoord;

const float PI = 3.141592;
vec4 RED = vec4(1, 0, 0, 1);
vec4 WHITE = vec4(1,1,1,1);

uniform bool classic = true;

void main()
{
    float distance = distance(vtexCoord, centre);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    if (smoothstep(radius - w, radius + w, distance) == 0) fragColor = RED;
    else fragColor = WHITE;

    if (!classic) {
        float phi = PI / 16;
        vec2 u = vtexCoord - centre;
        float theta = atan(u.s, u.t);
        if (mod(theta/phi + 0.5, 2) < 1) fragColor = RED;
    }
}
