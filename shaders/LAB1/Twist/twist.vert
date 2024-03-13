#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

float c = cos(0.4 * vertex.y * sin(time));
float s = sin(0.4 * vertex.y * sin(time));

mat3 rotation = mat3(vec3(c,0,-s),vec3(0,1,0),vec3(s,0,c));
void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(rotation * vertex, 1.0);
}
