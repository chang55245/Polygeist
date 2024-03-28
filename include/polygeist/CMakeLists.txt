add_mlir_dialect(PolygeistOps polygeist)
add_mlir_doc(PolygeistDialect -gen-dialect-doc PolygeistDialect Polygeist/)
add_mlir_doc(PolygeistOps -gen-op-doc PolygeistOps Polygeist/)

add_mlir_dialect(TaskflowOps taskflow)
add_mlir_doc(TaskflowOps  TaskflowOps   Polygeist/ -gen-op-doc)
add_mlir_doc(TaskflowDialect TaskflowDialect Polygeist/  -gen-dialect-doc)

add_subdirectory(Passes)