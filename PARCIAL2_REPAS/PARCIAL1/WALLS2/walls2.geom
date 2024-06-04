#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

uniform vec3 boundingBoxMin, boundingBoxMax;

void emitCube() {
	vec3 xyz = boundingBoxMin;
	vec3 xyZ = vec3(boundingBoxMin.x, boundingBoxMin.y, boundingBoxMax.z);
	vec3 xYz = vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z);
	vec3 xYZ = vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMax.z);
	vec3 Xyz = vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMin.z);
	vec3 XyZ = vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z);
	vec3 XYz = vec3(boundingBoxMax.x, boundingBoxMax.y, boundingBoxMin.z);
	vec3 XYZ = boundingBoxMax;

	gfrontColor = vec4(0,1,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
	EndPrimitive();

	gfrontColor = vec4(0,0,1,1);
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
	EndPrimitive();

	gfrontColor = vec4(1,0,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xyZ, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(xYZ, 1); EmitVertex();
	EndPrimitive();

	gfrontColor = vec4(1,0,0,1);
	gl_Position = modelViewProjectionMatrix * vec4(Xyz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYz, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XyZ, 1); EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(XYZ, 1); EmitVertex();
	EndPrimitive();
}

bool cameraInBox() {
	vec4 m = modelViewMatrix * vec4(boundingBoxMin, 1);
	vec4 M = modelViewMatrix * vec4(boundingBoxMax, 1);
	return (m.x < 0 && M.x > 0) && (m.y < 0 && M.y > 0) && (m.z < 0 && M.z > 0);
}

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		if (cameraInBox()) gfrontColor *= 2;
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	if (gl_PrimitiveIDIn == 0) emitCube();
}
