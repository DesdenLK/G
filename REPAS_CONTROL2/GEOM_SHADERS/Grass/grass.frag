#version 330 core

in vec3 geomNormal;
out vec4 fragColor;
in vec4 geomVertex;

uniform mat3 normalMatrix;

uniform sampler2D grassTop;
uniform sampler2D grassSide;

uniform float d;
void main()
{
    if (geomNormal.z == 0) {
        fragColor = texture(grassSide, vec2(4*(geomVertex.x - geomVertex.y), 1.0 - geomVertex.z/d));
        if (fragColor.a < 0.1) discard;
    }
    else fragColor = texture(grassTop, 4*geomVertex.xy);
}
