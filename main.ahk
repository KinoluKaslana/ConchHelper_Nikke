#Requires AutoHotkey v2.0

#Include <3rd\FindText>
#Include <utils>
#Include <mainFunc>


SetTimer nikkeWindowsInfoRefresh, 500, 0

mainGuiTitle := "Doro Conch(KK)"
mainGuiDefaultOpt := "-Resize +DPIScale +OwnDialogs"
mainGui := Gui(mainGuiDefaultOpt, mainGuiTitle)

mainGui.SetFont('s12', 'Microsoft YaHei UI')

mainGuiInfo := mainGui.AddGroupBox("X10 Y10 W250 R3 ", "信息")
mainGui.Add("Text","XP+5 YP+20 WP-10 HP-25" , "该版本为测试版本，目前只提供商店相关的功能，用于测试脚本国服&国际服相互兼容性。")

mainGuiProcessStatus := mainGui.Add("Text","X10 W250 R1","")
mainGuiProcessPos :=  mainGui.Add("Text","W250 R2","")

mainGuiFuncBox := mainGui.AddGroupBox("W250 R10 Section", "功能测试")

mainFuncObj := mainFunc().regFunc(mainGui, 200, "XS+5 YS+20 H30 W150")

mainGuiDoroBtn := mainGui.Add("Button", "W70 YS350 H20 XS", "DORO!")
mainGuiDoroBtn.OnEvent("Click", (mainGui, eventInfo) => mainFuncObj.action())

mainGuiSubfuncBox := mainGui.AddGroupBox("W250 Y10 R17.348 X270", "详细功能")

mainGui.OnEvent("Close", (guiObj)=> SetTimer(nikkeWindowsInfoRefresh, 0, 0 ))
mainGui.Show()