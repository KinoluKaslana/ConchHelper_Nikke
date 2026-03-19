#Requires AutoHotkey v2.0

#Include <3rd\FindText>
#Include <3rd\OCR>
#Include <helper>
#Include <mainFunc>
#SingleInstance Force

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}


mainGuiTitle := "Doro Conch(KK)"
mainGuiDefaultOpt := "-Resize +DPIScale +OwnDialogs"
mainGui := Gui(mainGuiDefaultOpt, mainGuiTitle)

mainGui.SetFont('s12', 'Microsoft YaHei UI')

logObj := AddLog("创建Log框架")
logObj.init(mainGui, "x535 y21.5 w300 H545")

mainGuiInfo := mainGui.AddGroupBox("X10 Y10 W250 R3 Section", "信息")
mainGui.Add("Text","XP+5 YP+20 WP-10 HP-25" , "该版本为测试版本，目前只提供商店相关的功能，用于测试脚本国服&国际服相互兼容性。")

;mainGuiProcessStatus := mainGui.Add("Text","X10 W250 R1","")
;mainGuiProcessPos :=  mainGui.Add("Text","W250 R2","")

mainGuiServerSelectCN := mainGui.Add("Radio", "X10 W250 R1 YS+130 Checked Group", "国服")
mainGuiServerSelectCN.OnEvent("Click", changeServer)
mainGuiServerSelectOther := mainGui.Add("Radio", "W250 R2", "国际服")
mainGuiServerSelectOther.OnEvent("Click", changeServer)

mainGuiFuncBox := mainGui.AddGroupBox("W250 R10 Section", "功能测试")   

mainFuncObj := mainFunc().regFunc(mainGui, 200, "XS+5 YS+20 H30 W150")

mainGuiDoroBtn := mainGui.Add("Button", "W70 YS350 H20 XS", "DORO!")
mainGuiDoroBtn.OnEvent("Click", (mainGui, eventInfo) =>(Sleep(200), mainFuncObj.action()))

mainGuiFindWindow := mainGui.Add("Text", "YS350 H20 XP+100 W100", "")
refreshInfoFunc := nikkePosWindowInfoRefresh.Bind(mainGuiFindWindow)

SetTimer(refreshInfoFunc, 500, 0)

mainGuiSubfuncBox := mainGui.AddGroupBox("W250 Y10 R17.348 X270", "详细功能")

mainGui.OnEvent("Close", (guiObj)=> SetTimer(refreshInfoFunc, 0, 0 ))
mainGui.Show()

^1:: {
    ExitApp
}

^2:: {
    ;Text := "|<>F8A397-0.90$29.0000000003rU007z0CEDy0TUTw0z07s1y0Dk3y0TU7w0z07s1y0DnXy0Tb7xzz6Dzzy4Tzzw8zzzsFzTzkXy0TV7w0z2Ds1y4Tk3w0TU7s0/0Dk060TV0A0y3"
    ;selfFindText(&X, &Y, nikkePosX + 0.632 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH . " ", nikkePosX + 0.632 * nikkePosW + 0.140 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH + 0.108 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, Text, , , , , , , zoomW * 1.5, zoomH * 1.5) ? "111" : "222"

    ;selfFindText().Click(X,Y,"L")
    
    ;Send "{]}"
    ;Sleep 200
    ;idleClick
    ;Sleep 200
    ;Send "{]}"
    ;Sleep 200
    ;idleClick
    ;Sleep 2000

    btnChallenge := [970 / 2560, 990 / 1440, 1260 / 2560, 1070 / 1440]
    btnMission := []
    btnEnter := []

    if(selfFindText(&X,&Y, nikkePosX + btnChallenge[1] * nikkePosW . " ", nikkePosY + btnChallenge[2] * nikkePosH . " ", nikkePosX + btnChallenge[3] * nikkePosW . " ", nikkePosY + btnChallenge[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)){
        AddLog("进入挑战关卡")
        clickBtn(btnChallenge *)
        Sleep 2000
        if(selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
            selfFindText().Click(X, Y, "L")
            Sleep 2000
        }
        else{
            AddLog("未找到挑战开放关卡")
        }
    }
    else{
        AddLog("挑战关卡无事件（红点）")
    }

    eventFormation(1)
    enterBattle()
    battleSettlement()
}

^3::{
    global outlineDebug
    outlineDebug := !outlineDebug
}