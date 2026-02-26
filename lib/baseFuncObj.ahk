#Requires AutoHotkey v2.0

class baseFuncObj {

    job := Array()

    action(){
        for func in this.job{
            func()
        }
    }

    addSubFunc := Func()
    
}