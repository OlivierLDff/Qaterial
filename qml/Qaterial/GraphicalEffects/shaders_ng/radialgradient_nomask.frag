#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 1) in vec2 qt_TexCoord1;
layout(location = 2) in vec2 centerPoint;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 center;
    vec2 matrixData;
    float horizontalRatio;
    float verticalRatio;
};

layout(binding = 1) uniform sampler2D gradientImage;

void main()
{
    vec4 gradientColor = texture(gradientImage, vec2(0.0, 2.0 * distance(qt_TexCoord1, centerPoint)));
    fragColor = gradientColor * qt_Opacity;
}
