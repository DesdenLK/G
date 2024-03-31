#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

vec4 BLUE = vec4(0,0.2,0.4,1);
vec4 WHITE = vec4(1);

bool circle (vec2 pos, vec2 centre, float radius) {
    float distance = distance(centre, pos);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    return smoothstep(radius-w,radius+w,distance) == 0;
}

bool rectangle(vec2 pos, vec2 centre, float x, float y) {
    if (pos.x < centre.x - x || pos.x > centre.x + x) return false;
    else if (pos.y < centre.y - y || pos.y > centre.y + y) return false;
    else return true;
}

void main()
{
    vec2 t = vec2(vtexCoord.s * 4, 3 * vtexCoord.t);
    if (rectangle(t, vec2(1.5,1.5), 0.9, 0.55)) fragColor = WHITE;
    else if (circle(t, vec2(1.8, 1.5),1.3)) fragColor = BLUE;
    else if (circle(t, vec2(2.5, 1.5),1.3)) fragColor = WHITE;
    else fragColor = BLUE;
}
