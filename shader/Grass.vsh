#version 400 core

precision highp float;

in vec4 positionMC;

void main(void)
{
	gl_Position = vec4(positionMC.xyz, 1.0);
}