#version 330 core

layout (location = 0) in vec3 vertex;



uniform mat4 modelViewMatrix;


void main()
{
    gl_Position = modelViewMatrix * vec4(vertex, 1.0);
}
