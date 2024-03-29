#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec4 vermell = vec4(1,0,0,1);
vec4 groc = vec4(1,1,0,1);
vec4 verd = vec4(0,1,0,1);
vec4 cian = vec4(0,1,1,1);
vec4 blau = vec4(0,0,1,1);

void main()
{



    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);

    float pos = 2 * ((gl_Position.y/gl_Position.w) + 1);

    if (pos == 0) frontColor = vermell;
    else if (pos < 1) frontColor = mix(vermell, groc, fract(pos));
    else if (pos < 2) frontColor = mix(groc, verd, fract(pos));
    else if (pos < 3) frontColor = mix(verd, cian, fract(pos));
    else if (pos < 4) frontColor = mix(cian, blau, fract(pos));
    else frontColor = blau;
}
