#version 440

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;

layout(location = 0) out vec2 qt_TexCoord0;
layout(location = 1) out vec2 qt_TexCoord1;
layout(location = 2) out vec2 centerPoint;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 center;
    vec2 matrixData;
    float horizontalRatio;
    float verticalRatio;
};

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    vec2 ratio = vec2(horizontalRatio, verticalRatio);

    mat2 rot = mat2(matrixData.y, -matrixData.x,
                    matrixData.x,  matrixData.y);

    qt_TexCoord0 = qt_MultiTexCoord0;

    qt_TexCoord1 = qt_MultiTexCoord0;
    qt_TexCoord1 -= center;
    qt_TexCoord1 *= rot;
    qt_TexCoord1 += center;
    qt_TexCoord1 *= ratio;

    centerPoint = center * ratio;

    gl_Position = qt_Matrix * qt_Vertex;
}
