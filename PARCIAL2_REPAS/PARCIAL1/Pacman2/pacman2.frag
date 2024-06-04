#version 330 core


in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D pacman;

uniform int N = 13;

bool cantonada(int x, int y) {
    return (x == 0 && y == 0) || (x == N-1 && y == N-1) || (x == 0 && y == N-1) || (x == N-1 && y == 0);
}

vec2 cantonadaCorrecte(int x, int y, float fx, float fy) {
    if (x == 0 && y == 0) return vec2(-(1/6.0 +  fx/6.0), -(y + fy));
    else if (x == 0 && y == N-1) return vec2(-(1/6.0 +  fx/6.0), y + fy);
    else if (x == N-1 && y == 0) return vec2(4/6.0 +  fx/6.0, -(y + fy));
    else return vec2(4/6.0 +  fx/6.0, y + fy);
}

bool borde(int x , int y) {
    return (!cantonada(x, y)) && (x == 0 || y == 0 || x == N-1 || y == N-1);
}

vec2 bordeCorrecte(int x, int y, float fx, float fy) {
    if (x == 0 || x == N-1) return vec2(3.01/6.0 + fy / 6.0, x + fx);
    return vec2(3.01/6.0 +  fx/6.0, y + fy);
}

vec2 construeixMapa(int x, int y, float fx, float fy) {
    if (x == 1 && y == N-2) return vec2(-(4/6.0 + fx/6.0), y + fy);
    if (x == int(N/2) && y == N-2) return vec2((0/6.0 + fx/6.0), y + fy);
    if (x == int(N/4) && y == N-2) return vec2((0/6.0 + fx/6.0), y + fy);

    if (y % 2 != 0) return vec2(5/6.0 + fx/6.0, y + fy);
    else {
        if (x != int(N/2)) {
            if (y < int(N / 2)) return vec2(3.01/6.0 + fy / 6.0, x + fx);
            return vec2(3.01/6.0 + fx/6.0, y + fy);
        }
        else return vec2(2.01/6.0 + fx/6.0, y + fy);
    }

}
void main()
{   
    vec2 coords = N * vtexCoord;
    int x = int(floor(coords.x));
    float fx = fract(coords.x);
    int y = int(floor(coords.y));
    float fy = fract(coords.y);

    vec2 c = vec2(fx * 1/6.0, coords.y);

    //POSAR BE LES CANTONADES
    if (cantonada(x,y)) c = cantonadaCorrecte(x,y,fx,fy);
    else if (borde(x,y)) c = bordeCorrecte(x,y,fx,fy);

    else c = construeixMapa(x, y, fx, fy);
    


    fragColor = texture(pacman, c);
}
