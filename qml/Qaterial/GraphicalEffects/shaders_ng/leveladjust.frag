#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    vec3 minimumInputRGB;
    vec3 maximumInputRGB;
    float minimumInputAlpha;
    float maximumInputAlpha;
    vec3 minimumOutputRGB;
    vec3 maximumOutputRGB;
    float minimumOutputAlpha;
    float maximumOutputAlpha;
    vec3 gamma;
};

layout(binding = 1) uniform sampler2D source;

float linearstep(float e0, float e1, float x)
{
    return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
}

void main()
{
    vec4 textureColor = texture(source, qt_TexCoord0.st);
    vec4 color = vec4(textureColor.rgb / max(1.0/256.0, textureColor.a), textureColor.a);

    color.r = linearstep(minimumInputRGB.r, maximumInputRGB.r, color.r);
    color.g = linearstep(minimumInputRGB.g, maximumInputRGB.g, color.g);
    color.b = linearstep(minimumInputRGB.b, maximumInputRGB.b, color.b);
    color.a = linearstep(minimumInputAlpha, maximumInputAlpha, color.a);

    color.rgb = pow(color.rgb, gamma);

    color.r = minimumOutputRGB.r + color.r * (maximumOutputRGB.r - minimumOutputRGB.r);
    color.g = minimumOutputRGB.g + color.g * (maximumOutputRGB.g - minimumOutputRGB.g);
    color.b = minimumOutputRGB.b + color.b * (maximumOutputRGB.b - minimumOutputRGB.b);
    color.a = minimumOutputAlpha + color.a * (maximumOutputAlpha - minimumOutputAlpha);

    fragColor = vec4(color.rgb * color.a, color.a) * qt_Opacity;
}
