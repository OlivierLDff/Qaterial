#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 1) in vec2 qt_TexCoord1;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 startPoint;
    vec2 matrixData;
    float l;
};

layout(binding = 1) uniform sampler2D source;
layout(binding = 2) uniform sampler2D maskSource;

void main()
{
    vec4 gradientColor = texture(source, qt_TexCoord1);
    float maskAlpha = texture(maskSource, qt_TexCoord0).a;
    fragColor = gradientColor * maskAlpha * qt_Opacity;
}
