#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

const float pi = 3.141592;

uniform float time;

uniform float speed = 1;

uniform mat4 modelViewProjectionMatrix;

void emitTriangle() {
	for (int i = 0; i < 3; ++i) {
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();

	}
	EndPrimitive();
}

void emitShrink(float shrink) {
	vec3 b = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz) / 3;
	for (int i = 0; i < 3; ++i) {
		gfrontColor = vfrontColor[i];
		vec4 new = mix(gl_in[i].gl_Position, vec4(b, 1), shrink);

		gl_Position = modelViewProjectionMatrix * vec4(new.xyz, 1);
		EmitVertex();
	}
	EndPrimitive();
}

void main( void )
{
	float shrink = abs(sin(2 * pi * 0.5 * time * speed));
	if (gl_PrimitiveIDIn % 2 == int(speed * time) % 2) emitTriangle();
	else emitShrink(shrink);
}
