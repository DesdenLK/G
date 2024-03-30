#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform int n = 5;

void main()
{
    if (int(gl_FragCoord.y) % n == 1) discard;
    else fragColor = frontColor;
}
