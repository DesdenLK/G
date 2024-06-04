#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;


out vec4 gfrontColor;
out vec2 gTextCoord;

uniform mat4 modelViewProjectionMatrix;

uniform int mode = 1;
uniform float cut = -0.25;

void creaCub(vec3 A, vec3 B, vec3 D)
{
	vec3 C = (A + B + D) / 3;
	bool estadins = (C.x < cut || C.y < cut || C.z < cut);
	gfrontColor = vec4((C + 1) / 2, 1);
	gTextCoord = vec2(0.5,0.5);
	
	if (mode < 3 || estadins) {
		vec3 xyz = vec3(C.x - 0.08, C.y - 0.08, C.z - 0.08);
		vec3 xyZ = vec3(C.x - 0.08, C.y - 0.08, C.z + 0.08);
		vec3 xYz = vec3(C.x - 0.08, C.y + 0.08, C.z - 0.08);
		vec3 xYZ = vec3(C.x - 0.08, C.y + 0.08, C.z + 0.08);
		vec3 Xyz = vec3(C.x + 0.08, C.y - 0.08, C.z - 0.08);
		vec3 XyZ = vec3(C.x + 0.08, C.y - 0.08, C.z + 0.08);
		vec3 XYz = vec3(C.x + 0.08, C.y + 0.08, C.z - 0.08);
		vec3 XYZ = vec3(C.x + 0.08, C.y + 0.08, C.z + 0.08);

		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		EndPrimitive();
		
		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTextCoord = vec2(0, 1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(0, 0);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		if (mode >= 2) gTextCoord = vec2(1, 0);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();
	}
}
void main( void )
{
	creaCub(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);
}
