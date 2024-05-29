#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vertexNormal[];
out vec4 gfrontColor;

uniform float disp = 0.05;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

vec3 normal (vec3 A, vec3 B, vec3 C) {
	vec3 AB = B - A;
	vec3 AC = C - A;

	return normalize(normalMatrix * normalize(cross(AB, AC)));
}

void emitSpikes(vec3 V0, vec3 V1, vec3 V2, vec4 C0, vec4 C1, vec4 C2, vec3 N) {
	vec3 V3 = (V0 + V1 + V2) / 3 + N * disp;

	float n0 = normal(V0,V1,V3).z;
	float n1 = normal(V1,V2,V3).z;
	float n2 = normal(V2,V0,V3).z;

	gfrontColor = C0 * n0;
	gl_Position = modelViewProjectionMatrix * vec4(V0, 1); EmitVertex();
	gfrontColor = C1 * n1;
	gl_Position = modelViewProjectionMatrix * vec4(V1, 1); EmitVertex();
	gfrontColor = vec4(1,1,1,1) * n0;
	gl_Position = modelViewProjectionMatrix * vec4(V3, 1); EmitVertex();
	EndPrimitive();

	gfrontColor = C1 * n1;
	gl_Position = modelViewProjectionMatrix * vec4(V1, 1); EmitVertex();
	gfrontColor = C2 * n2;
	gl_Position = modelViewProjectionMatrix * vec4(V2, 1); EmitVertex();
	gfrontColor = vec4(1,1,1,1) * n1;
	gl_Position = modelViewProjectionMatrix * vec4(V3, 1); EmitVertex();
	EndPrimitive();

	gfrontColor = C2 * n2;
	gl_Position = modelViewProjectionMatrix * vec4(V2, 1); EmitVertex();
	gfrontColor = C0 * n0;
	gl_Position = modelViewProjectionMatrix * vec4(V0, 1); EmitVertex();
	gfrontColor = vec4(1,1,1,1) * n2;
	gl_Position = modelViewProjectionMatrix * vec4(V3, 1); EmitVertex();
	EndPrimitive();
	
}

void main( void )
{
	vec3 N = normalize((vertexNormal[0] + vertexNormal[1] + vertexNormal[2]) / 2);
	emitSpikes(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz, vfrontColor[0], vfrontColor[1], vfrontColor[2], N);
}
