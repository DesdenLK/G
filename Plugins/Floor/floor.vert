#version 330 core

const vec3 red = vec3(1, 0, 0);
const vec3 green = vec3(0, 1, 0);

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 vertColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float lambda;

void main() {
	vec3 N = normalize(normalMatrix * normal);
	vec3 color = mix(red, green, lambda);
	vertColor = color * N.z;
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
