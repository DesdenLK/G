#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform int mode = 2;

vec4 BLACK = vec4(0, 0, 0, 1);
vec4 WHITE = vec4(1, 1, 1, 1);

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; 



uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;


vec4 Phong(vec3 N, vec3 V,vec3 L) {
    vec3 R = 2*dot(N,L)*N-L;
    N = normalize(N);
    R = normalize(R);
    V = normalize(V);
    L = normalize(L);
    float NperL = max(0.0, dot(N,L));
    float RperV = max(0.0, dot(R,V));
    float Idiff = NperL;
    float Ispec = 0.0;
    if (NperL > 0) Ispec = pow(RperV, matShininess);

    return matAmbient * lightAmbient + matDiffuse * lightDiffuse * Idiff + matSpecular * lightSpecular * Ispec;
}

bool circle(vec2 xy, vec2 center, float radius) {
    float d = distance(xy, center);
    float w = 0.7*length(vec2(dFdx(d),dFdy(d)));
    return smoothstep(radius - w, radius + w, d) == 0; 
}

void main()
{
    if (circle(vtexCoord, vec2(0, 0), 1)) {
        if (mode == 0) fragColor = BLACK;
        else {
            float s = vtexCoord.s, t = vtexCoord.t;
            vec3 P = vec3(s, t, sqrt(1 - (s * s) - (t * t)));
            vec3 N = P;
            fragColor = vec4(N.z);

            if (mode >= 2) {
                P = (modelViewMatrix * vec4(P, 1.0)).xyz;
                N = normalize(normalMatrix * N); 
                vec3 L = lightPosition.xyz - P;
                fragColor = Phong(N,-P,L);
            }
        }
    }
    
    else discard;
}
