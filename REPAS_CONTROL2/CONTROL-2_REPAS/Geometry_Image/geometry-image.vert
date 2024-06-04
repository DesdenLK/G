#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;

uniform sampler2D positionMap;
uniform sampler2D normalMap1; // observa el dígit 1 al final

uniform int mode = 0;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition;
uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 P = vec4(0,0,0,0);
vec4 Phong(vec3 N, vec3 R, vec3 V,vec3 L) {
    N = normalize(N);
    R = normalize(R);
    V = normalize(V);
    L = normalize(L);
    float NperL = max(0.0, dot(N,L));
    float RperV = max(0.0, dot(R,V));
    float Idiff = NperL;
    float Ispec = 0.0;
    if (NperL > 0) Ispec = pow(RperV, matShininess);

    if (mode == 3) return matAmbient * lightAmbient + P * lightDiffuse * Idiff + matSpecular * lightSpecular * Ispec;
    return matAmbient * lightAmbient + matDiffuse * lightDiffuse * Idiff + matSpecular * lightSpecular * Ispec;
}


void main()
{

    vec2 coords = (vertex.xy + 1) / 2 * 0.992 + 0.004;

    P = texture(positionMap, coords);
    vec4 C = texture(normalMap1, coords) * 2 -1;
    vec3 N = normalize(normalMatrix * C.xyz);

    vec3 V = vec3(P.x * 2 - 1, P.y * 2 - 1, P.z * 2 -1);

    if (mode == 0) frontColor = P;
    else if (mode == 1) frontColor = P * N.z;
    else if (mode == 2) {
        vec3 P = (modelViewMatrix * vec4(V, 1.0)).xyz;
        vec3 L = lightPosition.xyz - P;
        vec3 R = 2*dot(N,L)*N-L;
        frontColor = Phong(N,R,-P,L);
    }
    else {
        vec3 P2 = (modelViewMatrix * vec4(V, 1.0)).xyz;
        vec3 L = lightPosition.xyz - P2;
        vec3 R = 2*dot(N,L)*N-L;
        frontColor = Phong(N,R,-P2,L);
    }
    gl_Position = modelViewProjectionMatrix * vec4(V, 1.0);
}
