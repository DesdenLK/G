#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec3 v;
in vec3 N;

uniform mat4 modelViewMatrix;

uniform sampler2D noise;

vec4 shading(vec3 N, vec3 Pos, vec4 diffuse) {
    vec3 lightPos = vec3(0.0,0.0,2.0);
    vec3 L = normalize( lightPos - Pos );
    vec3 V = normalize( -Pos);
    vec3 R = reflect(-L,N);
    float NdotL = max( 0.0, dot( N,L ) );
    float RdotV = max( 0.0, dot( R,V ) );
    float Ispec = pow( RdotV, 20.0 );
    return diffuse * NdotL + Ispec;
}

vec4 WHITE = vec4(1,1,1,0);
vec4 REDDISH = vec4(0.5, 0.2, 0.2, 1);

float s = 0*v.x + 0.3*v.y -0.3*v.z;
float t = -0.6*v.x - 0.3*v.y + 0.3*v.z;

void main()
{
    float r = texture(noise, vec2(s,t)).r;
    vec4 color = vec4(0);
    if (r == 0) color = WHITE;
    else if (r < 0.5) color = mix(WHITE, REDDISH, fract(2*r));
    else if (r == 0.5) color = REDDISH;
    else if (r < 1.0) color = mix(REDDISH, WHITE, fract(2*r));
    else color = WHITE;

    fragColor = shading(N, (modelViewMatrix * vec4(v,1.0)).xyz, color);
}
