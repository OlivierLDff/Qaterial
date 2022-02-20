#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    float threshold;
    float spread;
};

layout(binding = 1) uniform sampler2D source;
layout(binding = 2) uniform sampler2D maskSource;

void main()
{
    vec4 colorFragment = texture(source, qt_TexCoord0.st);
    vec4 maskFragment = texture(maskSource, qt_TexCoord0.st);
    fragColor = colorFragment * smoothstep(threshold * (1.0 + spread) - spread, threshold * (1.0 + spread), maskFragment.a) * qt_Opacity;
}
