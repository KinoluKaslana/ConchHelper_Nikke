#Requires AutoHotkey v2.0

#Include <3rd\FindText>
;#Include <GuiCtrlTips>
#Include <Nikke\processcatch>


nikkeWindowsInfoRefresh(){
    global mainGuiProcessStatus, mainGuiProcessPos, processHWND 
    global nikkePosX, nikkePosY, nikkePosW, nikkePosH
    getNikkeHWND()
    getNikkePos()
    mainGuiProcessStatus.Text := "检查运行环境：" . (processHWND ? "游戏运行" : "未找到进程")
    mainGuiProcessPos.Text := "X="  nikkePosX "   Y=" nikkePosY "`nW=" nikkePosW "   H=" nikkePosH
}
stopNikkeWindowsInfoRefresh(thisGui){
    SetTimer nikkeWindowsInfoRefresh, 0, 0
    return 0
}


mainGuiTitle := "Doro Conch(KK)"
mainGuiDefaultOpt := "-Resize +DPIScale +OwnDialogs"
mainGui := Gui(mainGuiDefaultOpt, mainGuiTitle)

mainGui.SetFont('s12', 'Microsoft YaHei UI')

mainGuiInfo := mainGui.AddGroupBox("X10 Y10 W250 R3 ", "信息")
mainGui.Add("Text","XP+5 YP+20 WP-10 HP-25" , "该版本为测试版本，目前只提供商店相关的功能，用于测试脚本国服&国际服相互兼容性。")

mainGuiProcessStatus := mainGui.Add("Text","X10 W250 R1","")
mainGuiProcessPos :=  mainGui.Add("Text","W250 R2","")
SetTimer nikkeWindowsInfoRefresh, 500, 0
mainGui.OnEvent("Close", stopNikkeWindowsInfoRefresh)

mainGuiFuncBox := mainGui.AddGroupBox("W250 R10 ", "功能测试")
mainGuiSubfuncBox := mainGui.AddGroupBox("W250 Y10 R17.348 X+10", "详细功能")


mainGui.Show()