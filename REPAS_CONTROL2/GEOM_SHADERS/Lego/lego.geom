#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out vec2 geomTexturePos;
out vec3 geomNormal;

uniform float step = 0.2;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

vec3 normal (vec3 A, vec3 B, vec3 C) {
	vec3 AB = B - A;
	vec3 AC = C - A;
	return normalize(normalMatrix * normalize(cross(AB, AC)));
}
void emitCares(vec3 C) {
	float r = step / 2;
	vec3 xyz = vec3(C.x - r, C.y - r, C.z - r);
	vec3 xyZ = vec3(C.x - r, C.y - r, C.z + r);
	vec3 xYz = vec3(C.x - r, C.y + r, C.z - r);
	vec3 xYZ = vec3(C.x - r, C.y + r, C.z + r);
	vec3 Xyz = vec3(C.x + r, C.y - r, C.z - r);
	vec3 XyZ = vec3(C.x + r, C.y - r, C.z + r);
	vec3 XYz = vec3(C.x + r, C.y + r, C.z - r);
	vec3 XYZ = vec3(C.x + r, C.y + r, C.z + r);

	gfrontColor = vec4((vfrontColor[0].xyz +  vfrontColor[1].xyz + vfrontColor[2].xyz) / 3, 1);

	geomTexturePos = vec2(-1, -1);
	geomNormal = normal(xyz, Xyz, xYz);

	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);EmitVertex();
	EndPrimitive();

	geomNormal = normal(xyZ, XyZ, xYZ);
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);EmitVertex();
	EndPrimitive();

	geomNormal = normal(xyz, xyZ, xYz);
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);EmitVertex();
	EndPrimitive();

	geomNormal = normal(Xyz, XyZ, XYz);
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);EmitVertex();
	EndPrimitive();

	geomNormal = normal(xyz, xyZ, Xyz);
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1);EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1);EmitVertex();
	EndPrimitive();

	geomNormal = normal(xYz, xYZ, XYz);
	geomTexturePos = vec2(0,1);
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1);EmitVertex();
	geomTexturePos = vec2(0,0);
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1);EmitVertex();
	geomTexturePos = vec2(1,1);
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1);EmitVertex();
	geomTexturePos = vec2(1,0);
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1);EmitVertex();
	EndPrimitive();
	




}

void main( void )
{
	vec3 bar = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz) / 3;
	emitCares(step * round(bar / step));
}
