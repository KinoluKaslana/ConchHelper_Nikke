#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"

class shop extends baseFunc{

    func1(){
        MsgBox "Exec shop Func1"
    }
    func2(){
        MsgBox "Exec shop Func2"
    }

    init(mainGui, optStr){
        this.addCheckRow(mainGui,"Shop Func1",optStr, this.func1)
        this.addCheckRow(mainGui,"Shop Func2","",this.func2)
    }
} 