#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"

class event extends baseFunc{
    smallEvent(coordSet1, coordSet2){
        x1 := coordSet1[1]
        y1 := coordSet1[2]
        w1 := coordSet1[3] - coordSet1[1]
        h1 := coordSet1[4] - coordSet1[2]

        x2 := coordSet2[1]
        y2 := coordSet2[2]
        w2 := coordSet2[3] - coordSet2[1]
        h2 := coordSet2[4] - coordSet2[2]

        
    }

    init(mainGui, optStr){

    }
}