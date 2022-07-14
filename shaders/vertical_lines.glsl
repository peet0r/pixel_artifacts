#version 320 es

precision highp float;

layout(location = 0) out vec4 fragColor;

layout(location = 0) uniform vec2 size;

void main() {
    float m = gl_FragCoord.x - (2.0 * floor(gl_FragCoord.x/2.0));
    fragColor = vec4(floor(m));
}