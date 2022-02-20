#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    float desaturation;
};

layout(binding = 1) uniform sampler2D source;

void main(void)
{
    vec4 textureColor = texture(source, qt_TexCoord0.st);
    float grayColor = (textureColor.r + textureColor.g + textureColor.b) / 3.0;
    fragColor = mix(textureColor, vec4(vec3(grayColor), textureColor.a), desaturation) * qt_Opacity;
}
