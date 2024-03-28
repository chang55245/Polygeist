#ifndef TASKFLOW_OPS
#define TASKFLOW_OPS

include "TaskflowDialect.td"

include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Interfaces/ViewLikeInterface.td"
include "mlir/Interfaces/ControlFlowInterfaces.td"
include "mlir/IR/SymbolInterfaces.td"

include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/Dialect/LLVMIR/LLVMInterfaces.td"


def macOp : Taskflow_Op<"MAC"> {
	let summary = "MAC operation";
	let arguments = (ins I32:$mul_opa,I32:$mul_opb);
	let results = (outs I32:$accum_result);

	let builders = [
		OpBuilder<(ins "Value":$opaArg,"Value":$opbArg)>

	];
}
#endif //TASKFLOW_OPS