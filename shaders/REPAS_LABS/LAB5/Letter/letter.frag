#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

vec4 RED = vec4(1,0,0,1);

bool circle (vec2 pos, vec2 centre, float radius) {
    float distance = distance(centre, pos);
    float w = 0.7*length(vec2(dFdx(distance), dFdy(distance)));
    return smoothstep(radius-w,radius+w,distance) == 0;
}

void main()
{
    vec2 tex = vtexCoord*10;
    fragColor = vec4(1);
    for (int i = 3; i < 8; ++i) {
        if (circle(tex, vec2(4, i), 0.5)) fragColor = RED;
    }
    for (int i = 5; i < 8; ++i){
        if (circle(tex, vec2(i, 3), 0.5)) fragColor = RED;
    }
}
