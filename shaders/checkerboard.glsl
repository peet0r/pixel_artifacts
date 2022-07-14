#version 320 es

precision highp float;

layout(location = 0) out vec4 fragColor;

layout(location = 0) uniform vec2 size;

void main() {
    float my = gl_FragCoord.y - (2.0 * floor(gl_FragCoord.y/2.0));
    my = 1.0 - my;
    float x = gl_FragCoord.x + my;
    float mx = (x) - (2.0 * floor(x/2.0));
    fragColor = vec4(floor(mx));
}