#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

out vec4 geomColor;

const float areamax = 0.0005;

uniform mat4 projectionMatrix;

const vec4 RED = vec4(1,0,0,1);
const vec4 YELLOW = vec4(1,1,0,1);

float calcArea (vec3 A, vec3 B, vec3 C) {
	vec3 AB = B - A;
	vec3 AC = C - A;

	vec3 P = cross(AB,AC);
	return length(P) / 2;
}

void main( void )
{
	float a = calcArea(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);

	a /= areamax;
	geomColor = mix(RED, YELLOW, clamp(a,0,1));
	for( int i = 0 ; i < 3 ; i++ )
	{
		gl_Position = projectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();

	


}
