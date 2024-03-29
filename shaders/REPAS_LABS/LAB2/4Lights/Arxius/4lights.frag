#version 330 core

uniform mat4 modelViewMatrixInverse;

out vec4 fragColor;

in vec3 N;   	// normal (en object space)
in vec3 P; 	// posicio del vertex (en object space)

uniform float time;
uniform bool rotate;

// V, N, P, lightPos han d'estar al mateix espai de coordenades
// V �s el vector unitari cap a l'observador
// N �s la normal
// P �s la posici� 
// lightPos �s la posici� de la llum
// lightColor �s el color de la llum

vec3 pos1 = vec3(0, 10, 0);
vec3 pos2 = vec3(0, -10, 0);
vec3 pos3 = vec3(10, 0, 0);
vec3 pos4 = vec3(-10, 0, 0);

vec3 GREEN = vec3(0,1,0);
vec3 YELLOW = vec3(1,1,0);
vec3 BLUE = vec3(0,0,1);
vec3 RED = vec3(1,0,0);


vec4 light(vec3 V, vec3 N, vec3 P, vec3 lightPos, vec3 lightColor)
{
	const float shininess = 100.0;
	const float Kd = 0.5;
	N = normalize(N);
	vec3 L = normalize(lightPos - P);
	vec3 R = reflect(-L, N);
	float NdotL = max(0.0, dot(N,L));
	float RdotV = max(0.0, dot(R,V));
	float spec =  pow( RdotV, shininess);
	return vec4(Kd*lightColor*NdotL + vec3(spec),0);
}

void main()
{
	float angle = 0;
	if (rotate) angle = time;
	float cs = cos(angle);
	float sn = sin(angle);
	mat3 R = mat3(vec3(cs, sn, 0), vec3(-sn, cs,0), vec3(0,0,1));

	vec3 V = normalize(modelViewMatrixInverse[3].xyz - P);
	vec4 c = vec4(0);

	if (rotate) {
		pos1 = R * pos1;
		pos2 = R * pos2;
		pos3 = R * pos3;
		pos4 = R * pos4;
	}

	pos1 = (modelViewMatrixInverse * vec4(pos1, 1.0)).xyz;
	pos2 = (modelViewMatrixInverse * vec4(pos2, 1.0)).xyz;
	pos3 = (modelViewMatrixInverse * vec4(pos3, 1.0)).xyz;
	pos4 = (modelViewMatrixInverse * vec4(pos4, 1.0)).xyz;
	
	c = light(V, N, P, pos1, GREEN) + light(V, N, P, pos2, YELLOW) +
		light(V, N, P, pos3, BLUE) + light(V, N, P, pos4, RED);
	fragColor = c;
}

