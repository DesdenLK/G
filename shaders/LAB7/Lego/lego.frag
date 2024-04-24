#version 330 core

const vec4 RED = vec4(1,0,0,1);
const vec4 GREEN = vec4(0,1,0,1);
const vec4 BLUE = vec4(0,0,1,1);
const vec4 CYAN = vec4(0,1,1,1);
const vec4 YELLOW = vec4(1,1,0,1);

in vec4 gfrontColor;
in vec3 geomNormal;
in vec2 geomTexturePosition;

uniform sampler2D sampler;

out vec4 fragColor;
vec4 legoColor(vec4 color) {
    float r = distance(color, RED);
    float g = distance(color, GREEN);
    float b = distance(color, BLUE);
    float c = distance(color, CYAN);
    float y = distance(color, YELLOW);

    vec4 nearestColor = RED;
    float minimumDistance = r;

    if (g < minimumDistance) {minimumDistance = g; nearestColor = GREEN;}
    if (b < minimumDistance) {minimumDistance = b; nearestColor = BLUE;}
    if (c < minimumDistance) {minimumDistance = c; nearestColor = CYAN;}
    if (y < minimumDistance) {minimumDistance = y; nearestColor = YELLOW;}

    return nearestColor;
}
void main()
{
    vec4 color = legoColor(gfrontColor);
    if (geomTexturePosition.s >= 0 && geomTexturePosition.t >= 0) {
        color *= texture(sampler, geomTexturePosition);
    }
    fragColor = vec4((color * geomNormal.z).xyz,1);
}
