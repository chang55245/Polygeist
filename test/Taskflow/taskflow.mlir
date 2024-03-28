// information need to be here
// function
// dependency

func.func @callA() -> i32 {
    %a = 1
    return %a
}

func.func @callB() -> i32 {
    %b = 2
    return %b
}

func.func @callC() -> i32 {
    %c = 3
    return %c
}


func.func @main(%input : i32) -> () {
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

    tasflow.execute()
}