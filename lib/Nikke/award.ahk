#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"

class award extends baseFunc{

    func1(){
        MsgBox "Exec award Func1"
    }
    func2(){
        MsgBox "Exec award Func1"
    }
    
    init(mainGui, optStr){
        this.addCheckRow(mainGui,"Award Func1",optStr, this.func1)
        this.addCheckRow(mainGui,"Award Func2","",this.func2)
    }
} 