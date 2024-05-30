#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;
out vec2 gTextureCoords;

uniform mat4 projectionMatrix;
uniform float side = 0.1;

void emitQuad(vec3 V) {
	vec3 A = vec3(V.x - side, V.y - side, V.z);
	vec3 B = vec3(V.x - side, V.y + side, V.z);
	vec3 C = vec3(V.x + side, V.y - side, V.z);
	vec3 D = vec3(V.x + side, V.y + side, V.z);

	gTextureCoords = vec2(0, 0);
	gl_Position = projectionMatrix * vec4(A, 1);EmitVertex();
	gTextureCoords = vec2(0, 1);
	gl_Position = projectionMatrix * vec4(B, 1);EmitVertex();
	gTextureCoords = vec2(1, 0);
	gl_Position = projectionMatrix * vec4(C, 1);EmitVertex();
	gTextureCoords = vec2(1, 1);
	gl_Position = projectionMatrix * vec4(D, 1);EmitVertex();
	EndPrimitive();

}

void main( void )
{
	emitQuad(gl_in[0].gl_Position.xyz);
}
