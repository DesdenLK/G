#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 NEye;
in vec3 LEye;
in vec3 VEye;

in vec3 NWorld;
in vec3 LWorld;
in vec3 VWorld;


uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular

uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

uniform bool world = false;

vec4 Phong (vec3 N, vec3 L, vec3 V) {
    N = normalize(N);
    L = normalize(L);
    V = normalize(V);
    vec3  R = 2 * dot(N,L) * N -L;
    float NperL = max(0.0, dot(N,L));
    float RperV = max(0.0, dot(R,V));
    float Idiff = NperL;
    float Ispec = 0.0;
    if (NperL > 0) Ispec = pow(RperV, matShininess);

    return matAmbient * lightAmbient +
           matDiffuse * lightDiffuse * Idiff +
           matSpecular * lightSpecular * Ispec;
}

void main()
{
    if (!world) fragColor = Phong(NEye, LEye , VEye);
    else fragColor = Phong(NWorld, LWorld, VWorld);
}
