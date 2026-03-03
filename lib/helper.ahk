#Requires AutoHotkey v2.0
#Include "Nikke\processcatch.ahk"

picLibClientW := 3840
picLibClientH := 2160
PicTolerance := 1

zoomW := 1
zoomH := 1

changeServer(){
    global nikkeServer
    nikkeServer := !nikkeServer
}

nikkeWindowInfoRefresh(textGuiObj){
    global processHWND, nikkePosX, nikkePosY, nikkePosW, nikkePosH, zoomW, zoomH
    getNikkeHWND()
    getNikkePos()
    zoomW := nikkePosW / picLibClientW
    zoomH := nikkePosH / picLibClientH
    if (processHWND){
        textGuiObj.Text := "找到窗口"
    }
    else{
        textGuiObj.Text := "没找到窗口"
    }
}

scaledMove(x, y){
    CoordMode "Mouse", "Screen"
    Send "{Click " Round(x * zoomW) + nikkePosX " " Round(y*zoomH) + nikkePosY " 0}"
}

scaledClick(x, y){
    scaledMove(x, y)
    ;Click
    MsgBox "要求点击"
}

idleClick(){
    global processHWND
    ;点击左下角 280 1360处
    WinActivate processHWND
    scaledClick(420, 2040)
}

refuseSale() {
    if (ok := FindText(&X, &Y, nikkePosX + 0.438 * nikkePosW . " ", nikkePosY + 0.853 * nikkePosH . " ", nikkePosX + 0.438 * nikkePosW + 0.124 * nikkePosW . " ", nikkePosY + 0.853 * nikkePosH + 0.048 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("黄色的小时"), , , , , , , zoomW, zoomH)) {
        scaledClick(333, 2041)
        Sleep 500
        if (ok := FindText(&X, &Y, nikkePosX + 0.504 * nikkePosW . " ", nikkePosY + 0.594 * nikkePosH . " ", nikkePosX + 0.504 * nikkePosW + 0.127 * nikkePosW . " ", nikkePosY + 0.594 * nikkePosH + 0.065 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 500
        }
    }
}

backHall(){
    while true {
        if (ok := FindText(&X, &Y, nikkePosX + 0.658 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH . " ", nikkePosX + 0.658 * nikkePosW + 0.040 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH + 0.066 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("方舟的图标"), , 0, , , , , zoomW, zoomH)) {
            ; 点右上角的公告图标
            scaledClick(3568, 90)
            Sleep 500
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.477 * nikkePosW . " ", nikkePosY + 0.082 * nikkePosH . " ", nikkePosX + 0.477 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.082 * nikkePosH + 0.042 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("公告的图标"), , , , , , , zoomW, zoomH)) {
                ; AddLog("已返回大厅")
                loop 3 {
                    idleClick
                }
                Sleep 500
                break
            }
            else refuseSale
        }
        else {
            ; 点左下角的小房子的位置
            scaledClick(333, 2041)
            Sleep 500
            Send "{]}"
            refuseSale
        }
        if A_Index > 10 {
            scaledClick(1924, 1968)
            Sleep 500
        }
        if A_Index > 50 {
            MsgBox ("返回大厅失败，程序已中止")
            Pause
        }
    }
    Sleep 1000
}
