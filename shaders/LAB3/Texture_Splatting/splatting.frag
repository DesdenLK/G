#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D noise0;
uniform sampler2D rock1;
uniform sampler2D grass2;

in vec2 vtexCoord;


void main()
{
    float valor = texture(noise0, vtexCoord).r;
    vec4 color1 = texture(rock1, vtexCoord);
    vec4 color2 = texture(grass2, vtexCoord);
    fragColor = mix(color1,color2,valor);
}
