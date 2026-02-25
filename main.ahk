#Requires AutoHotkey v2.0

#Include <FindText>
;#Include <GuiCtrlTips>

mainGuiTitle := "Doro私有化 By Conch(KK)"
mainGuiDefaultOpt := "+Resize +DPIScale +OwnDialogs"
mainGui := Gui(mainGuiDefaultOpt, mainGuiTitle)

mainGui.SetFont('s12', 'Microsoft YaHei UI')

mainGui_Info := mainGui.AddGroupBox("x10 y10 w250 h210 ", "信息")


mainGui.Show()