#version 330

const vec3 waterColour = vec3(0.604, 0.867, 0.851);

out vec4 out_colour;

in vec4 pass_clipSpaceReal;

uniform sampler2D reflectionTexture;
uniform sampler2D refractionTexture;
uniform sampler2D depthTexture;

vec2 clipSpaceToTexCoords(vec4 clipSpace){
	vec2 ndc = (clipSpace.xy / clipSpace.w);
	vec2 texCoords = ndc / 2.0 + 0.5;
	return texCoords;
}

void main(void){

	vec2 texCoordsReal = clipSpaceToTexCoords(pass_clipSpaceReal);
	
	vec2 refractionTexCoords = texCoordsReal;
	vec2 reflectionTexCoords = vec2(texCoordsReal.x, 1.0 - texCoordsReal.y);
	
	vec3 refractColour = texture(refractionTexture, refractionTexCoords).rgb;
	vec3 reflectColour = texture(reflectionTexture, reflectionTexCoords).rgb;
	
	vec3 finalColour = mix(reflectColour, refractColour, 0.5);
	
	out_colour = vec4(finalColour, 1.0);

}