#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;



vec4 COLOR = vec4(0.7059, 0.2039, 0.051, 1.0);

bool es_cercle = false;

bool circle(vec2 xy, vec2 center, float radius) {
    float d = distance(center, xy);
    float w = 0.7*length(vec2(dFdx(d),dFdy(d)));
    return smoothstep(radius - w,radius + w, d) == 0;
}



void main()
{
    vec2 text = vec2(6*vtexCoord.x, 8*vtexCoord.y);
    for (int i = 1; !es_cercle && i < 8; ++i) {
        if (circle(text, vec2(1,i), 0.45)) es_cercle = true; 
    }
    for (int i = 2; !es_cercle && i < 6; ++i) {
        if (circle(text, vec2(i,1), 0.45)) es_cercle = true;;
    }
    if (es_cercle) fragColor = COLOR;
    else discard;

}
