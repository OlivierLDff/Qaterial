#ifndef __QATERIAL_EXPORT_HPP__
#define __QATERIAL_EXPORT_HPP__

#ifdef WIN32
#    ifdef QATERIAL_DLL_EXPORT
#        define QATERIAL_API_ __declspec(dllexport)
#    elif QATERIAL_STATIC
#        define QATERIAL_API_
#    else
#        define QATERIAL_API_ __declspec(dllimport)
#    endif
#else
#    define QATERIAL_API_
#endif

#endif
