#Requires AutoHotkey v2.0
#Include "Nikke\processcatch.ahk"

picLibClientW := 1920
picLibClientH := 1080

zoomW := 1
zoomH := 1

nikkeWindowsInfoRefresh(){
    global processHWND, nikkePosX, nikkePosY, nikkePosW, nikkePosH
    getNikkeHWND()
    getNikkePos()
    zoomW := nikkePosW / picLibClientW
    zoomH := nikkePosH / picLibClientH
}

