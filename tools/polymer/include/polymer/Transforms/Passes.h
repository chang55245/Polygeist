//===- Passes.h - Include Tblgen pass defs ------------C++-===//
#ifndef POLYMER_TRANSFORMS_PASSES_H
#define POLYMER_TRANSFORMS_PASSES_H

#include "mlir/Pass/Pass.h"

namespace polymer {

std::unique_ptr<mlir::OperationPass<mlir::FuncOp>> createAnnotateScopPass();

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "polymer/Transforms/Passes.h.inc"

} // namespace polymer

#endif
