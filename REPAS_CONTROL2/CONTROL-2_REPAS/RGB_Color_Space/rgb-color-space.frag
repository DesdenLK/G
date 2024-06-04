#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec2 gTextCoord;

void main()
{
    if (gTextCoord.s >= 0.05 && gTextCoord.s <= 0.95
        && gTextCoord.t >= 0.05 && gTextCoord.t <= 0.95) fragColor = gfrontColor;
    else fragColor = vec4(0,0,0,0);
}
