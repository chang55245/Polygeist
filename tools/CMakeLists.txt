add_subdirectory(polygeist-opt)
add_subdirectory(cgeist)
# add_subdirectory(taskflow-lsp)

if(POLYGEIST_ENABLE_POLYMER)
  add_subdirectory(polymer)
endif()
