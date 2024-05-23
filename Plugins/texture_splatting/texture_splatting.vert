#version 330 core
layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 1) in vec2 texCoord;

out vec2 vtexCoord;
out vec3 vNormal;

uniform float radius = 1.0;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
void main() {
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.);
    vNormal = normalMatrix * normal;
    vtexCoord = texCoord;
}