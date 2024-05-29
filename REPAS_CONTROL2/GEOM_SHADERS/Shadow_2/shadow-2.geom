#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform vec3 boundingBoxMin, boundingBoxMax;

void dibuixa_rectangle() {
	gfrontColor = vec4(0,1,1,1);
	float R = distance(boundingBoxMax, boundingBoxMin) / 2;
	vec3 C = (boundingBoxMax + boundingBoxMin) / 2;

	vec4 xyz = modelViewProjectionMatrix * vec4(C.x - R, boundingBoxMin.y - 0.01, C.z - R, 1);
	vec4 xyZ = modelViewProjectionMatrix * vec4(C.x - R, boundingBoxMin.y - 0.01, C.z + R, 1);
	vec4 Xyz = modelViewProjectionMatrix * vec4(C.x + R, boundingBoxMin.y - 0.01, C.z - R, 1);
	vec4 XyZ = modelViewProjectionMatrix * vec4(C.x + R, boundingBoxMin.y - 0.01, C.z + R, 1);

	gl_Position = xyz; EmitVertex();
	gl_Position = xyZ; EmitVertex();
	gl_Position = Xyz; EmitVertex();
	gl_Position = XyZ; EmitVertex();
	EndPrimitive();

}

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	gfrontColor = vec4(0,0,0,1);
	for (int i = 0; i < 3; ++i) {
		vec4 t = gl_in[i].gl_Position;
		gl_Position = modelViewProjectionMatrix * vec4(t.x, boundingBoxMin.y, t.z, 1);
		EmitVertex(); 
	}
	EndPrimitive();

	if (gl_PrimitiveIDIn == 0) dibuixa_rectangle();
}
