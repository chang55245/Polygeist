#ifndef TASKFLOW_OPS
#define TASKFLOW_OPS

include "TaskflowDialect.td"
include "TaskflowTypes.td"

include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Interfaces/ViewLikeInterface.td"
include "mlir/Interfaces/ControlFlowInterfaces.td"
include "mlir/IR/SymbolInterfaces.td"
include "mlir/IR/BuiltinAttributes.td"

include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/Dialect/LLVMIR/LLVMInterfaces.td"


def executeOp : Taskflow_Op<"execute"> {
	let summary = "execute operation";
	//no argument
	//no result
}

// def taskOp : Taskflow_Op<"task"> {
// 	let summary = "task operation";

// 	//arguments: a code region

// 	//attributes: task_name:string, dependence: tasknode
// 	let arguments = (ins OptionalAttr<Builtin_StringAttr>:$taskName);
// 	// task body a region of blocks
// 	let regions = (region SizedRegion<1>:$body);
// 	//results tasknode type var
// 	let results = (outs TaskNodeType:$outputTask);

// }

// def proceedOp : Taskflow_Op<"proceed"> {
// 	let summary = "proceed operation";
// 	// arguments: prev task, next task
// 	let arguments = (ins TaskNodeType:$prevTask, TaskNodeType:$nextTask);
// 	//no result
// }
#endif //TASKFLOW_OPS