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
float c = cos((vertex.y - 0.5)*sin(time));
float s = sin((vertex.y - 0.5)*sin(time));
mat3 rotation = mat3(1,0,0,0,c,s,0,-s,c);


void main()
{
    vec3 v = vertex + vec3(0,-1,0);
    frontColor = vec4(color,1.0);
    if (vertex.y > 0.5) v = rotation * v;
    v = v + vec3(0,1,0);
    gl_Position = modelViewProjectionMatrix * vec4(v, 1.0);
}
