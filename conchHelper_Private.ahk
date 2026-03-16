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
    MsgBox selfFindText(&X := "wait", &Y := 5, nikkePosX + (0.569 - 0.015 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.833 * nikkePosH . " ", nikkePosX + (0.569 - 0.015 * nikkeServer) * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.833 * nikkePosH + 0.069 * nikkePosH . " ", 0.15 * PicTolerance, 0.15 * PicTolerance, FindText().PicLib("无限之塔·向右的箭头"), , , , , , , zoomW, zoomH) ? "111" : "222"
}
^3::{
    global outlineDebug
    outlineDebug := !outlineDebug
}