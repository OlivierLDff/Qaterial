#version 440

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;

layout(location = 0) out vec2 qt_TexCoord0;
layout(location = 1) out vec2 qt_TexCoord1;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 startPoint;
    vec2 matrixData;
    float l;
};

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    mat2 rot = mat2(matrixData.y, -matrixData.x,
                    matrixData.x,  matrixData.y);

    qt_TexCoord0 = qt_MultiTexCoord0;

    qt_TexCoord1 = qt_MultiTexCoord0 * l;
    qt_TexCoord1 -= startPoint * l;
    qt_TexCoord1 *= rot;

    gl_Position = qt_Matrix * qt_Vertex;
}
