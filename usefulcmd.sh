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


# llvm ir
/heorot/lchang21/llvm-release/llvm/bin/clang++ -S -O0 -emit-llvm -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.cpp -I /heorot/lchang21/taskflow/taskflow/ -pthread -o lib.ll

# static library
/heorot/lchang21/llvm-release/llvm/bin/clang++ -c -std=c++17 -fPIE /heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.cpp -I /heorot/lchang21/taskflow/taskflow/ -pthread -o lib.o
/heorot/lchang21/llvm-release/llvm/bin/llvm-ar rcs lib.a lib.o

# use this static library
/heorot/lchang21/llvm-release/llvm/bin/clang++ -g -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/use.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread lib.a -o use.exe


# show ast, in command line
/heorot/lchang21/llvm-release/llvm/bin/clang-check -ast-dump -ast-dump-filter=main /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -- -std=c++17 -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread

# show ast, print to a file
/heorot/lchang21/llvm-release/llvm/bin/clang++ -Xclang -ast-dump -fsyntax-only -fno-color-diagnostics -Wno-visibility /heorot/lchang21/taskflow/taskflow/taskflow-lib/use.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread > ast.txt

# polygeist

CPLUS_INCLUDE_PATH=/home/lchang21/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/17.0.3/clangd_17.0.3/lib/clang/17/include/ /heorot/lchang21/llvm/Polygeist/build/bin/cgeist -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ --function=main -S

CPLUS_INCLUDE_PATH=/home/lchang21/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/17.0.3/clangd_17.0.3/lib/clang/17/include/ /heorot/lchang21/llvm/Polygeist/build/bin/cgeist -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ --function=main -S -emit-llvm

/heorot/lchang21/llvm-release/llvm/bin/clang++ -c -std=c++17 -fPIE /heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.cpp -I /heorot/lchang21/taskflow/taskflow/ -pthread -o lib.o
/heorot/lchang21/llvm-release/llvm/bin/llvm-ar rcs lib.a lib.o


/heorot/lchang21/llvm-release/llvm/bin/clang++  -g -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread lib.a -o test.exe


/heorot/lchang21/llvm/Polygeist/build/bin/polygeist-opt test-polygeist.mlir --canonicalize-polygeist  -convert-polygeist-to-llvm 


/heorot/lchang21/llvm/Polygeist/llvm-project/build/bin/mlir-opt -lower-affine -finalize-memref-to-llvm -convert-arith-to-llvm test-llvm.mlir



/heorot/lchang21/llvm-release/llvm/bin/clang++ -fPIC -shared -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.cpp -I /heorot/lchang21/taskflow/taskflow/ -pthread -o lib.so


/heorot/lchang21/llvm-release/llvm/bin/clang++  -g -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread -Wl,-rpath,/heorot/lchang21/taskflow/taskflow/taskflow-lib/ -L/heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.so lib.so -o test.exe


/heorot/lchang21/llvm/Polygeist/llvm-project/build/bin/mlir-cpu-runner ./emit-llvm-dialect.mlir -O3 -e main -entry-point-result=void -shared-libs=/heorot/lchang21/llvm/Polygeist/llvm-project/build/lib/libmlir_runner_utils.so,/heorot/lchang21/llvm/Polygeist/llvm-project/build/lib/libmlir_c_runner_utils.so,/heorot/lchang21/taskflow/taskflow/taskflow-lib/lib.so

CPLUS_INCLUDE_PATH=/home/lchang21/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/17.0.3/clangd_17.0.3/lib/clang/17/include/ /heorot/lchang21/llvm/Polygeist/build/bin/cgeist -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ --function=main -S -emit-llvm-dialect -o emit-llvm-dialect.mlir

# cgeist emit llvm--> compile to exe

CPLUS_INCLUDE_PATH=/home/lchang21/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/17.0.3/clangd_17.0.3/lib/clang/17/include/ /heorot/lchang21/llvm/Polygeist/build/bin/cgeist -std=c++17 /heorot/lchang21/taskflow/taskflow/taskflow-lib/test.cpp -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ --function=main -S -emit-llvm -o llvm.ll

/heorot/lchang21/llvm-release/llvm/bin/clang++  -g -std=c++17 llvm.ll -I /heorot/lchang21/taskflow/taskflow/taskflow-lib/ -pthread lib.a -o test.exe