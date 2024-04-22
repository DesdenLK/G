#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vertNormal[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform float speed = 0.5;
uniform float time;

vec3 average(vec3 P1, vec3 P2, vec3 P3) {
	return (P1+P2+P3) / 3;
}

void main( void )
{
	vec3 direction = average(vertNormal[0],vertNormal[1],vertNormal[2]);
	for( int i = 0 ; i < 3 ; i++ )
	{
		vec3 P = gl_in[i].gl_Position.xyz + speed * time * direction;
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * vec4(P, 1);
		EmitVertex();
	}
    EndPrimitive();
}
