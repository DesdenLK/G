#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec2 gTextureCoords;

uniform sampler2D sphere;

void main()
{
    fragColor = texture(sphere, gTextureCoords);
    if (fragColor.a != 1) discard;
}
