#version 400 core

in vec3 fragmentTexCoords;

out vec4 fragColor;

uniform samplerCube cubeMap;
uniform vec3 fogThickness;

void main(void)
{
     vec4 skyColor = texture( cubeMap, (fragmentTexCoords + vec3(0.5, 0.0, -0.5)) );
     fragColor = mix(skyColor, vec4(0.7), 11*fogThickness.x);
}