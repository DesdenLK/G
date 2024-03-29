#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform float speed = 0.1;

uniform sampler2D colorMap;

const float PI = 3.141592;
uniform float time;
uniform float a = 0.5;

float angle = 2 * PI * time;


void main()
{
    float c = cos(angle);
    float s = sin(angle);
    mat2 r = mat2 (c,s,-s,c);
    vec4 t = texture(colorMap, vtexCoord);
    float m = max(max(t.r,t.b),t.g);
    vec2 u = r * vec2(m);
    vec2 offset = (a/100.0) * u;
    vec2 tex = vtexCoord + offset;
    fragColor = frontColor * texture(colorMap, tex);
}
