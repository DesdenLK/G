#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D explosion;


uniform float time;

void main()
{
    float slice = 1/30.0;
    int frame = int(mod(time/slice, 48));
    int x = frame % 8;
    int y = 5 - frame / 8;

    vec2 tex = vec2(vtexCoord.s/8, vtexCoord.t/6);
    tex.x += x/8.0;
    tex.y += y/6.0;
    fragColor = texture(explosion, tex);
    fragColor *= fragColor.a;
}
