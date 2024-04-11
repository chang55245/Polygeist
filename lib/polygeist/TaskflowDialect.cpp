#include "polygeist/TaskflowDialect.h"
#include "mlir/IR/DialectImplementation.h"
#include "polygeist/TaskflowOps.h"
#include "polygeist/TaskflowTypes.h"
#include "llvm/ADT/TypeSwitch.h"

#include "polygeist/TaskflowOpsDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "polygeist/TaskflowOpsTypes.cpp.inc"
#define GET_OP_CLASSES
#include "polygeist/TaskflowOps.cpp.inc"


using namespace mlir;
using namespace mlir::taskflow;

//===----------------------------------------------------------------------===//
// Taskflow dialect.
//===----------------------------------------------------------------------===//

void TaskflowDialect::initialize() {

 addTypes<
#define GET_TYPEDEF_LIST
#include "polygeist/TaskflowOpsTypes.cpp.inc"
      >();

  addOperations<
#define GET_OP_LIST
#include "polygeist/TaskflowOps.cpp.inc"
      >();
}

