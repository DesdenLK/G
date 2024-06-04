#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;


uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform sampler2D positionMap;
uniform sampler2D normalMap1; // observa el dígit 1 al final 

uniform int mode = 2;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; 
uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 Phong(vec3 N, vec3 R, vec3 V,vec3 L, vec3 P) {
    N = normalize(N);
    R = normalize(R);
    V = normalize(V);
    L = normalize(L);
    float NperL = max(0.0, dot(N,L));
    float RperV = max(0.0, dot(R,V));
    float Idiff = NperL;
    float Ispec = 0.0;
    if (NperL > 0) Ispec = pow(RperV, matShininess);

    if (P != vec3(-10,-10,-10)) return matAmbient * lightAmbient + vec4(P, 1) * lightDiffuse * Idiff + matSpecular * lightSpecular * Ispec;
    return matAmbient * lightAmbient + matDiffuse * lightDiffuse * Idiff + matSpecular * lightSpecular * Ispec;
}

void main()
{
    vec2 coords = (vertex.xy + 1) / 2 * 0.992 + 0.004;

    vec3 P = texture(positionMap, coords).xyz;
    vec3 N = texture(normalMap1, coords).xyz * 2 - 1;

    N = normalize(normalMatrix * N);

    if (mode == 0) frontColor = vec4(P, 1);
    else if (mode == 1) frontColor = vec4(P, 1) * N.z;
    else {
        vec3 P2 = (modelViewMatrix * vec4(P, 1.0)).xyz;
        vec3 V = -P2;
        vec3 L = lightPosition.xyz - P2;
        vec3 R = 2*dot(N,L)*N-L;
        if (mode == 2) frontColor = Phong(N,R,V,L, vec3(-10,-10,-10));
        else frontColor = Phong(N,R,V,L, P);
    }
    gl_Position = modelViewProjectionMatrix * vec4(P * 2 - 1 , 1.0);
}
