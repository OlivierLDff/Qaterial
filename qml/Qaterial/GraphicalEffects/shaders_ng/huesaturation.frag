#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    vec3 hsl;
};

layout(binding = 1) uniform sampler2D source;

vec3 RGBtoHSL(vec3 color)
{
    float cmin = min(color.r, min(color.g, color.b));
    float cmax = max(color.r, max(color.g, color.b));
    float h = 0.0;
    float s = 0.0;
    float l = (cmin + cmax) / 2.0;
    float diff = cmax - cmin;

    if (diff > 1.0 / 256.0) {
        if (l < 0.5)
            s = diff / (cmin + cmax);
        else
            s = diff / (2.0 - (cmin + cmax));

        if (color.r == cmax)
            h = (color.g - color.b) / diff;
        else if (color.g == cmax)
            h = 2.0 + (color.b - color.r) / diff;
        else
            h = 4.0 + (color.r - color.g) / diff;

        h /= 6.0;
    }
    return vec3(h, s, l);
}

float hueToIntensity(float v1, float v2, float h)
{
    h = fract(h);
    if (h < 1.0 / 6.0)
        return v1 + (v2 - v1) * 6.0 * h;
    else if (h < 1.0 / 2.0)
        return v2;
    else if (h < 2.0 / 3.0)
        return v1 + (v2 - v1) * 6.0 * (2.0 / 3.0 - h);

    return v1;
}

vec3 HSLtoRGB(vec3 color)
{
    float h = color.x;
    float l = color.z;
    float s = color.y;

    if (s < 1.0 / 256.0)
        return vec3(l);

    float v1;
    float v2;
    if (l < 0.5)
        v2 = l * (1.0 + s);
    else
        v2 = (l + s) - (s * l);

    v1 = 2.0 * l - v2;

    float d = 1.0 / 3.0;
    float r = hueToIntensity(v1, v2, h + d);
    float g = hueToIntensity(v1, v2, h);
    float b = hueToIntensity(v1, v2, h - d);
    return vec3(r, g, b);
}

void main()
{
    vec4 samp = texture(source, qt_TexCoord0);
    samp = vec4(samp.rgb / max(1.0/256.0, samp.a), samp.a);
    samp.rgb = mix(vec3(dot(samp.rgb, vec3(0.2125, 0.7154, 0.0721))), samp.rgb, 1.0 + hsl.y);
    samp.xyz = RGBtoHSL(samp.rgb);
    samp.rgb = HSLtoRGB(vec3(samp.x + hsl.x, samp.y, samp.z));
    float c = step(0.0, hsl.z);
    samp.rgb = mix(samp.rgb, vec3(c), abs(hsl.z));
    fragColor = vec4(samp.rgb * samp.a, samp.a) * qt_Opacity;
}
