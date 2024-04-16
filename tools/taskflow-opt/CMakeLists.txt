get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)


add_llvm_tool(taskflow-opt
taskflow-opt.cpp
)

set(LIBS
        ${dialect_libs}
        ${conversion_libs}
        MLIROptLib
		MLIRPolygeist
		MLIRPolygeistTransforms
		MLIRFuncAllExtensions
        )

target_link_libraries(taskflow-opt PRIVATE ${LIBS})


