# td file

/heorot/lchang21/llvm/Polygeist/llvm-project/build/bin/mlir-tblgen -gen-op-defs /heorot/lchang21/llvm/Polygeist/include/polygeist/TaskflowDialect.td -I /heorot/lchang21/llvm/Polygeist/llvm-project/mlir/include

/heorot/lchang21/llvm/Polygeist/build/bin/polygeist-opt taskflow.mlir -allow-unregistered-dialect


{
      "clangd.path": "/home/lchang21/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/17.0.3/clangd_17.0.3/bin/clangd",
      "mlir.pdll_server_path": "/heorot/lchang21/llvm/Polygeist/llvm-project/build/bin/mlir-pdll-lsp-server",
      "mlir.server_path": "/heorot/lchang21/llvm/Polygeist/build/bin/taskflow-lsp-server",
      "mlir.tablegen_server_path": "/heorot/lchang21/llvm/Polygeist/llvm-project/build/bin/tblgen-lsp-server",
      "mlir.tablegen_compilation_databases": [
        "/heorot/lchang21/llvm/Polygeist/build/tablegen_compile_commands.yml"   
      ],
      "editor.bracketPairColorization.enabled": true,
      "editor.guides.bracketPairs":"active"
}