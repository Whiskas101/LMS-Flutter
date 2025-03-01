#version 460 core

#include <flutter/runtime_effect.glsl>
precision mediump float;

uniform vec2 uSize;
uniform float time;
uniform lowp sampler2D _texture; // because mobile is weak



out vec4 FragColor;

void main(){
    vec2 uv = FlutterFragCoord().xy / uSize;
    vec2 pos = vec2(100.0)/uSize;

    vec4 text = texture(_texture, uv);
    vec4 neonColor = vec4(0.3, 0.8, 0.01, text.a); // hard coded color as glow for now

    float glowIntensity = 0.6 + 0.4 * sin(time * 3.0);
    vec3 glow = neonColor.rgb * glowIntensity * text.a;
    
    float dist = length(uv - pos);
    float radius = 1.0;
    float glow2 = exp(dist * radius) * 1.5; 
    // combining the glow with the base color 
    vec4 finalColor = vec4(text.rgba * glow2);

    // vec3 finalColor = text.rgb + glow;
    // vec4 finalColor = text.rgba + glowIntensity;
    // vec3 finalColor = text.rgb + glow * text.a;

    // FragColor = vec4(finalColor.rgb, text.a);
    FragColor = finalColor;
    // FragColor = vec4(0.318,0.373,1.000,1.000);
}













