add_mlir_dialect_library(MLIRPolygeist
Dialect.cpp
Ops.cpp
TaskflowDialect.cpp
TaskflowOps.cpp

ADDITIONAL_HEADER_DIRS
${PROJECT_SOURCE_DIR}/include/polygeist

DEPENDS
MLIRPolygeistOpsIncGen

LINK_LIBS PUBLIC
MLIRIR
MLIRMemRefDialect
MLIRLLVMDialect
MLIROpenMPDialect
MLIRAffineDialect
MLIRSupport
MLIRSCFTransforms
)
add_subdirectory(Passes)
add_subdirectory(ExecutionEngine)
