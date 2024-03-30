#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

void main()
{
    vec2 tex = vtexCoord*9;
    if (int(tex.s) % 9 % 2 == 0) fragColor = vec4(1,1,0,1);
    else fragColor = vec4(1,0,0,1);
}
