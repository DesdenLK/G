#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

uniform vec3 boundingBoxMin;

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
}
