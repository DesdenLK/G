#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform int mode = 2;

vec4 BLACK = vec4(0,0,0,1);
vec4 GREY = vec4(0.8,0.8,0.8,1);
vec4 SKIN = vec4(1, 0.8, 0.6, 1);
vec4 WHITE= vec4(1.0, 1.0, 1.0, 1.0);


bool circle(vec2 xy, vec2 center, float radius) {
    float d = distance(xy, center);
    float w = 0.7*length(vec2(dFdx(d),dFdy(d)));
    return smoothstep(radius - w, radius + w, d) == 0; 
}

bool elipse(vec2 xy, vec2 center, float radius, float defx, float defy) {
    vec2 v = xy - center;
    float d = distance(vec2(defx * v.x, defy * v.y), vec2(0,0));
    float w = 0.7*length(vec2(dFdx(d),dFdy(d)));
    return smoothstep(radius - w, radius + w, d) == 0;

}

void main()
{
    vec2 xy = vec2(vtexCoord.s*10, vtexCoord.t*10);
    if (mode == 2 && elipse (xy, vec2(4.5,4.5), 0.75, 2, 1) ||
                     elipse (xy, vec2(5.5,4.5), 0.75, 2, 1)) fragColor = BLACK;

    else if (mode == 2 && elipse (xy, vec2(4.5,5), 1.5, 2, 1) ||
                          elipse (xy, vec2(5.5,5), 1.5, 2, 1)) fragColor = WHITE;

    else if (mode > 0 && (elipse(xy, vec2(5, 3), 3, 1, 2) ||
        elipse(xy, vec2(4.5, 5), 2, 2, 1) ||
        elipse(xy, vec2(5.5, 5), 2, 2, 1))) fragColor = SKIN;

    else if (circle(xy, vec2(5, 4), 3.5) ||
        circle(xy, vec2(2, 8), 2) ||
        circle(xy, vec2(8, 8), 2)) fragColor = BLACK;

    
    else fragColor = GREY;
}
