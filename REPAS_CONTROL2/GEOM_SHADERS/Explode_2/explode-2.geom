#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in vec4 vfrontColor[];
in vec3 vertNormal[];

out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform float speed = 0.5;
uniform float angSpeed = 8.0;
uniform float time;

vec3 rotate(vec3 P, float angle, vec3 axis) {
	float s = sin(angle);
	float c = cos(angle);
	float d = 1 - c;
	float xx = axis.x * axis.x;
	float yy = axis.y * axis.y;
	float zz = axis.z * axis.z;
	float xs = axis.x * s;
	float ys = axis.y * s;
	float zs = axis.z * s;
	float xyd = axis.x * axis.y * d;
	float xzd = axis.x * axis.z * d;
	float yzd = axis.y * axis.z * d;
	return mat3(
		xx * d + c, xyd - zs, xzd + ys,
		xyd + zs, yy * d + c, yzd - xs,
		xzd - ys, yzd + xs, zz * d + c) * P;
}

vec3 explosion(vec3 P, vec3 direction) {
	return rotate(P, angSpeed * time, direction) + speed * time * direction;
}

vec3 average(vec3 P1, vec3 P2, vec3 P3) {
	return (P1 + P2 + P3) / 3;
}

void main(void) {
	vec3 direction = average(vertNormal[0], vertNormal[1], vertNormal[2]);
	for (int i = 0; i < 3; i++) {
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix *
			vec4(explosion(gl_in[i].gl_Position.xyz, direction), 1.0);
		EmitVertex();
	}
}
