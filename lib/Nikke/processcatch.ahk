#Requires AutoHotkey v2.0

processHWND := 0
nikkePosX := -1
nikkePosY := -1
nikkePosW := -1
nikkePosH := -1

;0 = 国服
;1 = 国际服
nikkeServer := 1

getNikkePosHWND(){
    global processHWND
    windowTitle := nikkeServer ? "胜利女神" : "NIKKE"
    processName := "nikke.exe"
    SetTitleMatchMode 1

    return processHWND := WinExist(windowTitle . " ahk_exe " . processName)
}

getNikkePos(){
    global nikkePosX 
    global nikkePosY 
    global nikkePosW 
    global nikkePosH
    global processHWND
    if(processHWND == 0){
        nikkePosH := nikkePosW := nikkePosX := nikkePosY := -1
        return
    }
    WinGetClientPos &nikkePosX, &nikkePosY, &nikkePosW, &nikkePosH, "ahk_id " processHWND
}
