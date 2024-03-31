#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D digits;

const float dni [8] = float[8] (2,3,8,4,2,3,5,4);
void main()
{
    int x = int(vtexCoord.x * 8);
    float num = dni[x] * 0.1;
    float s = num + fract(vtexCoord.s * 8) * 0.1;
    vec4 color = texture(digits, vec2(s, vtexCoord.t));
    if (color.a < 0.5) discard;
    else fragColor = vec4(0,0,1,1);
}
