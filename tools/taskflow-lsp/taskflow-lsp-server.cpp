//====- buddy-lsp-server.cpp - The LSP server of buddy-mlir --------------------------===//
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//===----------------------------------------------------------------------===//
//
// This file is a LSP server for new dialects of buddy-mlir project.
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Tools/mlir-lsp-server/MlirLspServerMain.h"

#include "polygeist/Dialect.h"
#include "polygeist/Ops.h"
#include "polygeist/TaskflowDialect.h"
#include "polygeist/TaskflowOps.h"
#include "polygeist/TaskflowTypes.h"


using namespace mlir;


int main(int argc, char **argv) {
  DialectRegistry registry;
  registerAllDialects(registry);
  // clang-format off
  registry.insert<polygeist::PolygeistDialect,
                  taskflow::TaskflowDialect>();
  return failed(MlirLspServerMain(argc, argv, registry));
}