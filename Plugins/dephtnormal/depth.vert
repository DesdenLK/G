#version 330 core

layout (location = 0) in vec3 position;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 translate, scale;

void main() {
	gl_Position = modelViewProjectionMatrix * vec4(position, 1.0);
}
