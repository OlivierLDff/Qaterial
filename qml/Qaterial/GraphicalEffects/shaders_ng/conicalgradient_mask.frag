#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 center;
    float startAngle;
};

layout(binding = 1) uniform sampler2D gradientSource;
layout(binding = 2) uniform sampler2D maskSource;

void main()
{
    float maskAlpha = texture(maskSource, qt_TexCoord0).a;
    const float PI = 3.14159265;
    const float PIx2inv = 0.1591549;
    float a = (atan((center.y - qt_TexCoord0.t), (center.x - qt_TexCoord0.s)) + PI - startAngle) * PIx2inv;
    fragColor = texture(gradientSource, vec2(0.0, fract(a))) * maskAlpha * qt_Opacity;
}
