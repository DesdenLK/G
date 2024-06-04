#version 330 core

in vec4 frontColor;
out vec4 fragColor;

void main()
{
    fragColor = vec4(gl_FragCoord.zzz, 1);
}
