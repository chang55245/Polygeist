// information need to be here
// function
// dependency

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
    %a = taskflow.taskdef{
        // %ct = func.call @callA() : () -> index
    }
    %b = taskflow.taskdef{
        // func.call @callA() : () -> ()
    }

    taskflow.proceed(%a, %b)
    taskflow.execute
    return
}