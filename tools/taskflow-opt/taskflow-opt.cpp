
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllExtensions.h"
#include "mlir/InitAllPasses.h"

#include "mlir/Support/FileUtilities.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"



#include "polygeist/TaskflowDialect.h"


// namespace mlir {
// namespace taskflow {

// } // namespace taskflow
// } // namespace mlir

int main(int argc, char **argv) {
  // Register all MLIR passes.
  mlir::registerAllPasses();

  mlir::DialectRegistry registry;
  // Register all MLIR core dialects.
  registerAllDialects(registry);
  mlir::registerAllExtensions(registry);
  registry.insert<mlir::taskflow::TaskflowDialect>();
  return mlir::failed(
      mlir::MlirOptMain(argc, argv, "buddy-mlir optimizer driver", registry));
}