#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec3 geomNormal;

in vec3 vertNormal[];
uniform float d = 0.5;

uniform mat4 modelViewProjectionMatrix;

vec3 normal (vec3 A, vec3 B, vec3 C) {
	vec3 AB = B - A;
	vec3 AC = C - A;

	return cross(AB, AC);
}
void emitPrisme (vec3 V0, vec3 V1, vec3 V2, vec3 N) {
	vec3 U0 = V0 + d * N;
	vec3 U1 = V1 + d * N;
	vec3 U2 = V2 + d * N;

	geomNormal = -normal(V0, V1, V2);
	gl_Position = modelViewProjectionMatrix * vec4(V0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(V1,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(V2,1); EmitVertex();
	EndPrimitive();

	geomNormal = normal(U0, U1, U2);
	gl_Position = modelViewProjectionMatrix * vec4(U0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U1,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U2,1); EmitVertex();
	EndPrimitive();

	geomNormal = normal(V0, U0, V1);
	gl_Position = modelViewProjectionMatrix * vec4(V0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(V1,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U1,1); EmitVertex();
	EndPrimitive();

	geomNormal = normal(V0, U0, V2);
	gl_Position = modelViewProjectionMatrix * vec4(V0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U0,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(V2,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U2,1); EmitVertex();
	EndPrimitive();

	geomNormal = normal(V2, U2, V1);
	gl_Position = modelViewProjectionMatrix * vec4(V2,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U2,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(V1,1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(U1,1); EmitVertex();
	EndPrimitive();

}
void main( void )
{
	vec3 N = normalize((vertNormal[0] + vertNormal[1] + vertNormal[2]) / 3);
	emitPrisme(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz, N);
}
