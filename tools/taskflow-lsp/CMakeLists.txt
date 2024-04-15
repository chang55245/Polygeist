get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

add_llvm_tool(taskflow-lsp-server
  taskflow-lsp-server.cpp
)

target_link_libraries(taskflow-lsp-server
  PRIVATE
  ${dialect_libs}
  ${conversion_libs}
  MLIRLspServerLib
)