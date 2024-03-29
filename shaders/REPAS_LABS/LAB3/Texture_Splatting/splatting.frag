#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D noise0;
uniform sampler2D rock1;
uniform sampler2D grass2;

void main()
{
    float r = texture(noise0, vtexCoord).r;
    vec4 rock = texture(rock1, vtexCoord);
    vec4 grass = texture(grass2, vtexCoord);
    fragColor = mix(rock, grass, r);
}
