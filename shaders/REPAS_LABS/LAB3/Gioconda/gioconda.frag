#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

uniform sampler2D gioconda;
uniform float time;

vec2 centre = vec2(0.393, 0.652);
float radius = 0.025;


void main()
{
    vec2 text = vtexCoord;
    if (fract(time) > 0.5 && distance(text, centre) <= radius) {
        text += vec2(0.057, -0.172);
    }
    fragColor = texture(gioconda, text);
}
