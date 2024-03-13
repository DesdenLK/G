#version 330 core

out vec4 fragColor;

uniform sampler2D explosion;
uniform sampler2D frameMap1;
uniform float time;

in vec2 vtexCoord;

void main()
{
    float slice = 1.0/30;
    int frame = int(mod(time/slice, 48));
    int x = frame % 8;
    int y = 5 - frame / 8;

    vec2 text = vtexCoord*vec2(1/8.0,1/6.0);
    text.x += x/8.0;
    text.y += y/6.0;
    fragColor = texture(explosion, text);
    fragColor *= fragColor.a;
}