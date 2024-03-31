#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

vec4 reverse (vec4 vertex) {
    return vec4(vertex.xy, -vertex.z, vertex.w);
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * abs(N.z);
    vtexCoord = texCoord;
    gl_Position = reverse(modelViewProjectionMatrix * vec4(vertex, 1.0));
}