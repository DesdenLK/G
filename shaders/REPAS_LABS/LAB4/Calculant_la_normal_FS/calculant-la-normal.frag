#version 330 core

in vec4 frontColor;
in vec3 V;
out vec4 fragColor;

void main()
{
    vec3 normal = normalize(cross(dFdx(V),dFdy(V)));
    fragColor = frontColor * normal.z;
}
