#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in float pos;
uniform float time;

void main()
{
    if (pos <= time) fragColor = vec4(0, 0, 1.0, 1.0);
    else discard;
}
