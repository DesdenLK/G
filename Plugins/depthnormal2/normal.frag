#version 330 core

in vec3 N;
out vec4 fragColor;

void main()
{
    fragColor = vec4((N + 1) / 2, 1);
}
