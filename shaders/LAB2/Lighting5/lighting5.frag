#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; 



uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

in vec3 NEye;
in vec3 LEye;
in vec3 VEye;

in vec3 NWorld;
in vec3 LWorld;
in vec3 VWorld;

uniform bool world;

vec4 light(vec3 N, vec3 V, vec3 L)
{
    N=normalize(N); V=normalize(V); L=normalize(L);
    vec3 R = normalize( 2.0*dot(N,L)*N-L );
    float NdotL = max( 0.0, dot( N,L ) );
    float RdotV = max( 0.0, dot( R,V ) );
    float Idiff = NdotL;
    float Ispec = 0;
    if (NdotL>0) Ispec=pow( RdotV, matShininess );
    return
    matAmbient * lightAmbient +
    matDiffuse * lightDiffuse * Idiff+
    matSpecular * lightSpecular * Ispec;
}

void main()
{
    if (world) fragColor = light(NWorld, VWorld, LWorld);
    else fragColor = light(NEye, VEye, LEye);
}
