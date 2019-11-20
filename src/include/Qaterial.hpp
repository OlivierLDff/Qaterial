#ifndef __QATERIAL_HPP__
#define __QATERIAL_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header
#include <QObject>
#include <QString>

// Dependencies Header

// Application Header

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

#ifdef WIN32
    #ifdef QATERIAL_SHARED  // Shared build
        #define QATERIAL_API_ __declspec(dllexport)
    #elif QATERIAL_STATIC   // No decoration when building staticlly
        #define QATERIAL_API_
    #else               // Link to lib
        #define QATERIAL_API_ __declspec(dllimport)
    #endif
#else
    #define QATERIAL_API_
#endif

#ifdef QATERIAL_USE_NAMESPACE
#ifndef QATERIAL_NAMESPACE
#define QATERIAL_NAMESPACE Qaterial
#endif
#define QATERIAL_NAMESPACE_START namespace QATERIAL_NAMESPACE {
#define QATERIAL_NAMESPACE_END }
#define QATERIAL_USING_NAMESPACE using namespace QATERIAL_NAMESPACE;
#else
#undef QATERIAL_NAMESPACE
#define QATERIAL_NAMESPACE
#define QATERIAL_NAMESPACE_START
#define QATERIAL_NAMESPACE_END
#define QATERIAL_USING_NAMESPACE
#endif

QATERIAL_NAMESPACE_START

// ─────────────────────────────────────────────────────────────
//                  CLASS
// ─────────────────────────────────────────────────────────────

/**
 */
class QATERIAL_API_ Helper
{
public:
    static void registerTypes(const char* uri = nullptr);
    static void loadResources();
    /** Library Major Version */
    static quint32 major();
    /** Library Minor Version */
    static quint32 minor();
    /** Library Patch Version */
    static quint32 patch();
    /** Library Tag Version */
    static quint32 tag();
    /** get version in form major.minor.patch.tag */
    static QString version();
};

class QATERIAL_API_ Version : public QObject
{
    Q_OBJECT

protected:
    Q_PROPERTY(quint32 major READ major CONSTANT);
    Q_PROPERTY(quint32 minor READ minor CONSTANT);
    Q_PROPERTY(quint32 patch READ patch CONSTANT);
    Q_PROPERTY(quint32 tag READ tag CONSTANT);
    Q_PROPERTY(QString version READ version CONSTANT);

    quint32 major() const;
    quint32 minor() const;
    quint32 patch() const;
    quint32 tag() const;
    QString version() const;
};

QATERIAL_NAMESPACE_END

#endif
