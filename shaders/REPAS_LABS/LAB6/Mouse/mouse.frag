#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

vec4 GREY = vec4(0.8);
vec4 BLACK = vec4(0);
vec4 SKIN = vec4(1.0, 0.8, 0.6, 1);
vec4 WHITE = vec4(1);

uniform int mode = 2;

bool circle (vec2 pos, vec2 centre, float r) {
    float distance = distance(centre, pos);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    return smoothstep(r-w,r+w,distance) == 0;
}

bool elipse (vec2 pos, vec2 centre, float r, float x, float y) {
    vec2 P = pos-centre;
    P = vec2 (P.x*x, P.y*y);
    float distance = sqrt(P.x*P.x+P.y*P.y);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    return smoothstep(r-w,r+w,distance) == 0;
}

void main()
{
    vec2 tex = vtexCoord*10;

    if (circle(tex, vec2(2,8), 2) || circle(tex, vec2(8,8), 2)) fragColor = BLACK;
    else if (circle(tex, vec2(5, 4), 3.5)) fragColor = BLACK;
    else fragColor = GREY;

    if (mode >= 1) {
        if (elipse(tex, vec2(4.5, 5), 2, 2, 1) ||
            elipse(tex, vec2(5.5, 5), 2, 2, 1) ||
            elipse(tex, vec2(5, 3), 3, 1, 2)) fragColor = SKIN;
    }
    if (mode == 2) {
        if (elipse(tex, vec2(4.5, 4.5), 0.75, 2, 1) ||
            elipse(tex, vec2(5.5, 4.5), 0.75, 2, 1)) fragColor = BLACK;
        else if (elipse(tex, vec2(4.5, 5), 1.5, 2, 1) ||
            elipse(tex, vec2(5.5, 5), 1.5, 2, 1)) fragColor = WHITE;
    }
}
