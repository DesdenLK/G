#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

bool cantonada(int x, int y) {
    return x == 14 && y == 14 ||
        x == 14 && y == 0 ||
        x == 0 && y == 14 ||
        x == 0 && y == 0;
}

bool borde (int x, int y) {
    return !cantonada(x,y) && (x == 0 || y == 0 || x == 14 || y == 14);
}

uniform sampler2D tex;

void main()
{
    vec2 coords = vtexCoord*15;
    int x = int(floor(vtexCoord.x*15));
    float fx = fract(vtexCoord.x*15);
    int y = int(floor(vtexCoord.y*15));
    float fy = fract(vtexCoord.y*15);

    float s = coords.x;
    float t = coords.y;
    
    if (cantonada(x,y)) s = 4/6.0 + fx * 1/6.0;
    if (cantonada(x,y) && x == 14 && y == 0) {t = coords.x; s = -(1/6.0 + fy *1/6.0);}
    if (cantonada(x,y) && x == 0 && y == 0) {t = -coords.x; s = -(1/6.0 + fy *1/6.0);}
    if (cantonada(x,y) && x == 0 && y == 14) {t = -coords.x; s = (4/6.0 + fy *1/6.0);}


    if (borde(x,y)) s = 3.01/6.0 + fx * 1/6.0;
    if (borde(x,y) && (x == 0 || x == 14)){t = -coords.x; s = (3.01/6.0 + fy *1/6.0);}

    if (!borde(x,y) && !cantonada(x,y)) s = 5/6.0 + fx * 1/6.0;
    if (!borde(x,y) && !cantonada(x,y) && x % 3 !=  0 && y % 2 == 0) s = 3/6.0 + fx * 1/6.0;
    if (!borde(x,y) && !cantonada(x,y) && x % 4 ==  0 && y % 3 != 0
        && y < 5) {t = -coords.x; s = (3.01/6.0 + fy *1/6.0);}

    if ((x == 10 && y == 7) || (x == 7 && y == 11)) s = 0/6.0 + fx * 1/6.0;
    if (x == 6 && y == 2) s = 1/6.0 + fx * 1/6.0;
    if (x > 4 && x < 8 && y == 1) s = 2 /6.0 + fx * 1/6.0;
    //t = vtexCoord.x; s = 3/6.0 + fract(vtexCoord.y) *1/6.0;
    fragColor = texture(tex, vec2(s,t));
    //else s = vtexCoord.x * 1/6.0 + fract(vtexCoord.x) * 1/6.0;
}