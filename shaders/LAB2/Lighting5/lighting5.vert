#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;


out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 viewMatrixInverse;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

out vec3 NEye;
out vec3 LEye;
out vec3 VEye;

out vec3 NWorld;
out vec3 LWorld;
out vec3 VWorld;

void main()
{
    vec3 P = (modelViewMatrix * vec4(vertex.xyz,1)).xyz;
    NEye = normalize(normalMatrix * normal);
    VEye = -P;
    LEye = lightPosition.xyz - P;

    NWorld = normal;
    LWorld = (viewMatrixInverse * lightPosition).xyz - vertex.xyz;
    VWorld = (viewMatrixInverse*vec4(0,0,0,1)).xyz - vertex.xyz;

    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
