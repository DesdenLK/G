#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D colorMap;

const float dni[6] = float[6](2,3,8,4,2,3);
void main()
{
    int val = int(floor(vtexCoord.x*6));
    float fractionCoord = fract(vtexCoord.x*6);
    float s = dni[val]* 0.1 + fractionCoord * 0.1;
    vec4 textureColor = texture(colorMap, vec2(s, vtexCoord.t));

    if (textureColor.a < 0.5) discard;
    else fragColor = vec4(0,0,1,1);
}
