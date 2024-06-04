#version 330 core

out vec4 fragColor;
in vec3 N;
uniform vec4 color;

void main() {
	fragColor = vec4((N + 1) / 2, 1);
}