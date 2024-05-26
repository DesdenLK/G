#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

vec4 red = vec4(1,0,0,1);
vec4 green = vec4(0,1,0,1);
vec4 blue = vec4(0,0,1,1);

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

void emitBoundingBoxVertices() {
	vec3 m = boundingBoxMin;
	vec3 M = boundingBoxMax;

	vec4 xyz = modelViewProjectionMatrix * vec4(m.x,m.y,m.z,1);
	vec4 xyZ = modelViewProjectionMatrix * vec4(m.x,m.y,M.z,1);
	vec4 xYz = modelViewProjectionMatrix * vec4(m.x,M.y,m.z,1);
	vec4 xYZ = modelViewProjectionMatrix * vec4(m.x,M.y,M.z,1);
	vec4 Xyz = modelViewProjectionMatrix * vec4(M.x,m.y,m.z,1);
	vec4 XyZ = modelViewProjectionMatrix * vec4(M.x,m.y,M.z,1);
	vec4 XYz = modelViewProjectionMatrix * vec4(M.x,M.y,m.z,1);
	vec4 XYZ = modelViewProjectionMatrix * vec4(M.x,M.y,M.z,1);

	gfrontColor = red;
	gl_Position = xyZ; EmitVertex();
	gl_Position = xYZ; EmitVertex();
	gl_Position = xyz; EmitVertex();
	gl_Position = xYz; EmitVertex();
	EndPrimitive();
	gfrontColor = blue;
	gl_Position = xyz; EmitVertex();
	gl_Position = xYz; EmitVertex();
	gl_Position = Xyz; EmitVertex();
	gl_Position = XYz; EmitVertex();
	EndPrimitive();
	gfrontColor = red;
	gl_Position = XyZ; EmitVertex();
	gl_Position = XYZ; EmitVertex();
	gl_Position = Xyz; EmitVertex();
	gl_Position = XYz; EmitVertex();
	EndPrimitive();
	gfrontColor = green;
	gl_Position = xyZ; EmitVertex();
	gl_Position = xyz; EmitVertex();
	gl_Position = XyZ; EmitVertex();
	gl_Position = Xyz; EmitVertex();
	EndPrimitive();



}

bool camera_inside() {
	vec4 m = modelViewMatrix * vec4(boundingBoxMin, 1);
	vec4 M = modelViewMatrix * vec4(boundingBoxMax, 1);
	return m.x < 0 && 0 < M.x && m.y < 0 && 0 < M.y && m.z < 0 && 0 < M.z;
}

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		if (camera_inside()) gfrontColor = vfrontColor[i] * 2;
		else gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	if (gl_PrimitiveIDIn == 0) emitBoundingBoxVertices();
}
