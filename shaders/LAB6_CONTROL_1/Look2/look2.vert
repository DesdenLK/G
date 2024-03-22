#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;


uniform float angle = 0.75;




void main()
{
    float t;
    if (vertex.y <= 1.45) t = 0;
    else if (vertex.y >= 1.55) t = 1;
    else {
        t = smoothstep(1.45, 1.55, vertex.y);
    }

    float c = cos(angle * t);
    float s = sin(angle * t);
    mat4 rotation = mat4(c,0,-s,0,0,1,0,0,s,0,c,0,0,0,0,1);
    
    vec3 N = normalize(normalMatrix * (rotation * vec4(normal, 0)).xyz);

    frontColor = vec4(vec3(N.z), 1);
    gl_Position = modelViewProjectionMatrix * rotation * vec4(vertex, 1);
}
