#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform mat4 modelViewProjectionMatrix;
uniform int mode = 1;

uniform float cut = -0.25;


out vec4 gfrontColor;
out vec2 gTexCoord;

void emitCube() {
	vec3 A = gl_in[0].gl_Position.xyz;
	vec3 B = gl_in[1].gl_Position.xyz;
	vec3 D = gl_in[2].gl_Position.xyz;

	vec3 C = (A + B + D) / 3;

	vec3 xyz = vec3(C.x - 0.08, C.y - 0.08, C.z - 0.08);
	vec3 xyZ = vec3(C.x - 0.08, C.y - 0.08, C.z + 0.08);
	vec3 xYz = vec3(C.x - 0.08, C.y + 0.08, C.z - 0.08);
	vec3 xYZ = vec3(C.x - 0.08, C.y + 0.08, C.z + 0.08);
	vec3 Xyz = vec3(C.x + 0.08, C.y - 0.08, C.z - 0.08);
	vec3 XyZ = vec3(C.x + 0.08, C.y - 0.08, C.z + 0.08);
	vec3 XYz = vec3(C.x + 0.08, C.y + 0.08, C.z - 0.08);
	vec3 XYZ = vec3(C.x + 0.08, C.y + 0.08, C.z + 0.08);

	vec4 color = vec4((C + 1) / 2,1);
	gfrontColor = color;
	gTexCoord = vec2(0.5,0.5);

	if (mode < 3 || C.x < cut || C.y < cut || C.z < cut){
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		EndPrimitive();

		
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
		EndPrimitive();

		if (mode >= 2) gTexCoord = vec2(0,0);
		gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(0,1);
		gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,0);
		gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
		if (mode >= 2) gTexCoord = vec2(1,1);
		gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
		EndPrimitive();
	}
	
}

void main( void )
{
	emitCube();
}
