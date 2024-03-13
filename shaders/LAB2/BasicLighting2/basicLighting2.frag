#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 norm;

void main()
{
    vec3 N = normalize(norm);
    fragColor = frontColor * N.z;
}
