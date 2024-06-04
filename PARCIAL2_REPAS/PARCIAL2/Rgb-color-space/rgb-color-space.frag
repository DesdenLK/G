#version 330 core

in vec4 gfrontColor;
in vec2 gTexCoord;
out vec4 fragColor;

void main()
{
    if (gTexCoord.s > 0.05 && gTexCoord.s < 0.95 && gTexCoord.t > 0.05 && gTexCoord.t < 0.95) fragColor = gfrontColor;
    else fragColor = vec4(0,0,0,1);
}
