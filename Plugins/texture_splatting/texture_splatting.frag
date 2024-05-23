#version 330 core

in vec2 vtexCoord;
in vec3 vNormal;

out vec4 fragColor;

uniform sampler2D sampler0;
uniform sampler2D sampler1;
uniform sampler2D sampler2;

void main() {
    float p = texture(sampler0, vtexCoord).r;
    vec4 c1 = texture(sampler1, vtexCoord);
    vec4 c2 = texture(sampler2, vtexCoord);

    fragColor = mix(c1,c2, p) * vNormal.z;
}
