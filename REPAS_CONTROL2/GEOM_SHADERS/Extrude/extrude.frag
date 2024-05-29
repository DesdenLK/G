#version 330 core

in vec3 geomNormal;
out vec4 fragColor;

uniform mat3 normalMatrix;
void main()
{
    fragColor = vec4(normalize(normalMatrix * geomNormal).zzz, 1);
}
