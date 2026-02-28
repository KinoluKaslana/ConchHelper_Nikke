#Requires AutoHotkey v2.0
#Include "Nikke\processcatch.ahk"

nikkeWindowsInfoRefresh(){
    global processHWND, nikkePosX, nikkePosY, nikkePosW, nikkePosH
    getNikkeHWND()
    getNikkePos()
}
