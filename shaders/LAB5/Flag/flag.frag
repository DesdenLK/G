#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

vec2 c1 = vec2(1, 1.5);
vec2 c2 = vec2(2.5,1.5);
vec2 c3 = vec2(1.7,1.5);


vec4 WHITE = vec4(1.0, 1.0, 1.0, 1.0);
vec4 BLUE = vec4(0.1216, 0.2667, 0.4588, 1.0);

bool circle(vec2 xy, vec2 center, float radius) {
    float d = distance(center, xy);
    float w = 0.7*length(vec2(dFdx(d),dFdy(d)));
    return smoothstep(radius - w,radius + w, d) == 0;
}


void main()
{
    vec2 xy = vec2(4*vtexCoord.x, 3*vtexCoord.y);
    if (circle(xy, c1, 0.65)) fragColor = WHITE;
    else if (circle(xy, c3, 1.2)) fragColor = BLUE;
    else if (circle(xy, c2, 1.2)) fragColor = WHITE;
    else fragColor = BLUE;
}
