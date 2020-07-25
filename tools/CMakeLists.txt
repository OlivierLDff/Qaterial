
if(QATERIAL_ENABLE_HOTRELOAD OR QATERIAL_ENABLE_HOTRELOAD_LIB)
  add_subdirectory(HotReload)
endif()

if(QATERIAL_ENABLE_HELLOWORLD)
  add_subdirectory(HelloWorld)
endif()
