#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;


out vec4 gfrontColor;

uniform mat4 projectionMatrix;

const vec4 RED = vec4(1,0,0,1);
const vec4 YELLOW = vec4(1,1,0,1);

float calcula_area() {
	vec3 AB = gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz;
	vec3 AC = gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz;

	return length(cross(AB, AC)) / 2;
}

void main( void )
{

	float area = calcula_area();
	gfrontColor = mix(RED, YELLOW, area/0.0005);
	for( int i = 0 ; i < 3 ; i++ )
	{
		gl_Position = projectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
}
