#version 400 core

precision highp float;

layout (points) in;
layout (triangle_strip, max_vertices = 4) out;

uniform mat4 viewProj;
uniform vec3 eyeposition;

// GS for billboard technique
// based on http://ogldev.atspace.co.uk/www/tutorial27/tutorial27.html
void main()                                                                         
{
    //streak size
    float height = 0.05;
    float width = height/10.0;
                                                                                 
    vec3 pos = gl_in[0].gl_Position.xyz;                                            
    vec3 toCamera = normalize(eyeposition - pos);                                    
    vec3 up = vec3(0.0, 1.0, 0.0);                                                  
    vec3 right = cross(toCamera, up) * width;                              
                                                                                    
    pos -= right;                                                                   
    gl_Position = viewProj * vec4(pos, 1.0);                                                     
    EmitVertex();                                                                   
                                                                                    
    pos.y += height;                                                        
    gl_Position = viewProj * vec4(pos, 1.0);                                                          
    EmitVertex();                                                                   
                                                                                    
    pos.y -= height;                                                        
    pos += right;                                                                   
    gl_Position = viewProj * vec4(pos, 1.0);                                             
    EmitVertex();                                                                   
                                                                                    
    pos.y += height;                                                        
    gl_Position = viewProj * vec4(pos, 1.0);                                             
    EmitVertex();                                                                   
                                                                                    
    EndPrimitive();                                                                 
}