#ifndef TASKFLOW_TYPES_H_
#define TASKFLOW_TYPES_H_

// Required because the .h.inc file refers to MLIR classes and does not itself
// have any includes.
#include "mlir/include/mlir/IR/DialectImplementation.h"

#define GET_TYPEDEF_CLASSES
#include "polygeist/TaskflowTypes.h.inc"

#endif  // TASKFLOW_TYPES_H_