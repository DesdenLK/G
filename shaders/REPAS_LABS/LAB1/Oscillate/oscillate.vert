#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

float y = (modelViewMatrix * vec4(vertex, 1.0)).y;
float d;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform bool eyespace;
uniform float time;

const float PI = 3.141592;

vec3 oscillation(vec3 vertex) {
	float y = eyespace ? (modelViewMatrix * vec4(vertex, 1.0)).y : vertex.y;
	float r = distance(boundingBoxMin, boundingBoxMax) / 2.0;
	float d = (r / 10.0) * y;
	return vertex + normal * d * sin(time);
}


void main()
{
    float r = distance(boundingBoxMax, boundingBoxMin) / 2.0;
    if (eyespace) d = (r / 10) * y;
    else d = (r / 10) * vertex.y;

    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(oscillation(vertex), 1.0);
}
