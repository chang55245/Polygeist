// information need to be here
// function
// dependency

func.func @taskflow_parallel_template(%input : memref<i32>) -> () {
// dependencies need to be analyzed using a pass
tasflow.task (name="A", dependencies=["B"]) {
    print("A")
    %outa = call @callA(%arga) : () -> i32
}

tasflow.task (name="B", dependencies=["C"]) {
    print("B")
    %outb = call @callB(%argb) : () -> i32
}


tasflow.task (name="C", dependencies=[]) {
    print("C")
    %outc = call @callC(%argc) : () -> i32
}
}