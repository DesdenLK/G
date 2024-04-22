#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

in vec4 vfrontColor[];
out vec4 gfrontColor;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();


	gfrontColor = vec4(0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		vec4 P = gl_in[i].gl_Position;
		P.y *= 0;
		P.y += boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix * P;
		EmitVertex();
	}
    EndPrimitive();

	if (gl_PrimitiveIDIn == 0) {
		gfrontColor = vec4(0,1,1,1);
		float R = distance(boundingBoxMax, boundingBoxMin);
		R = R / 2;
		vec3 center = (boundingBoxMax + boundingBoxMin) / 2;
		center.y = boundingBoxMin.y - 0.01;
		gl_Position = modelViewProjectionMatrix * vec4(center + vec3(-R,0,-R), 1);
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * vec4(center + vec3(R,0,-R), 1);
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * vec4(center + vec3(-R,0,R), 1);
		EmitVertex();
		gl_Position = modelViewProjectionMatrix * vec4(center + vec3(R,0,R), 1);
		EmitVertex();
	}
	EndPrimitive();
}
