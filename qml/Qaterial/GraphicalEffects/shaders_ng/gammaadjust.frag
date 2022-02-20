#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    float gamma;
};

layout(binding = 1) uniform sampler2D source;

void main()
{
    vec4 originalColor = texture(source, qt_TexCoord0.st);
    originalColor.rgb = originalColor.rgb / max(1.0/256.0, originalColor.a);
    vec3 adjustedColor = pow(originalColor.rgb, vec3(gamma));
    fragColor = vec4(adjustedColor * originalColor.a, originalColor.a) * qt_Opacity;
}
