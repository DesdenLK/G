#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vertNormal[];
out vec4 gfrontColor;

uniform float speed = 0.5;
uniform float time;

uniform mat4 modelViewProjectionMatrix;

vec3 normal_promig() {
	return (vertNormal[0] + vertNormal[1] + vertNormal[2]) / 3;
}

void main( void )
{
	vec3 n = normal_promig();
	for( int i = 0 ; i < 3 ; i++ )
	{
		vec3 P = gl_in[i].gl_Position.xyz + speed * time * n;
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * vec4(P, 1);
		EmitVertex();
	}
    EndPrimitive();
}
