#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;

uniform mat4 modelViewProjectionMatrix;

out vec3 N;

void main() {
	N = normal;
	gl_Position = modelViewProjectionMatrix * vec4(position, 1.0);
}
