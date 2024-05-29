#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;
in vec2 geomTexturePos;
in vec3 geomNormal;

uniform sampler2D lego;

vec4 RED = vec4 (1,0,0,1);
vec4 GREEN = vec4 (0,1,0,1);
vec4 BLUE = vec4 (0,0,1,1);
vec4 CYAN = vec4 (0,1,1,1);
vec4 YELLOW = vec4 (1,1,0,1);

vec3 legoColor (vec4 color) {
    float r = distance(color, RED);
    float g = distance(color, GREEN);
    float b = distance(color, BLUE);
    float c = distance(color, CYAN);
    float y = distance(color, YELLOW);

    vec4 col = RED;
    float md = r;
    if (g < md) {md = g; col = GREEN;}
    if (b < md) {md = b; col = BLUE;}
    if (c < md) {md = c; col = CYAN;}
    if (y < md) {md = y; col = YELLOW;}

    return col.xyz;
    
}

void main()
{
    fragColor = vec4(legoColor(gfrontColor), 1) * geomNormal.z;
    if (geomTexturePos.s != -1 && geomTexturePos.t != -1) {
        fragColor *= texture(lego, geomTexturePos);
    } 
}
