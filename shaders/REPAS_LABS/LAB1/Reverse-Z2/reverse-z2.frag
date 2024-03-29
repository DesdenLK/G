#version 330 core

in vec4 frontColor;
out vec4 fragColor;

void main()
{
    fragColor = frontColor;
    gl_FragDepth = 1.0 - gl_FragCoord.z;
}
