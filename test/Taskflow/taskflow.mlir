func.func @callA() -> index {
    %c1 = arith.constant 1 : index
    return %c1:index
}

func.func @callB() -> index {
    %c1 = arith.constant 1 : index
    return %c1:index
}

func.func @callC() -> index {
    %c1 = arith.constant 1 : index
    return %c1:index
}


func.func @main(%input : i32) {
// dependencies need to be analyzed using a pass
    // %a = taskflow.taskdef() {name="A", dependencies=["B"]}:() -> i32 {      
    //     func.call @callA() : () -> ()
    // }
    %a = taskflow.task{
        %ct = func.call @callA() : () -> index
        taskflow.yield
    }
    %b = taskflow.task{
        %ct = func.call @callB() : () -> index
        taskflow.yield
    }
    %c = taskflow.task{
        %ct = func.call @callB() : () -> index
        taskflow.yield
    }

    taskflow.proceed(%a, %b)
    taskflow.proceed(%c, %b)
    taskflow.execute
    return
}