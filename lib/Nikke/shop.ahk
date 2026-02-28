#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\3rd\FindText.ahk"
#Include "..\3rd\PicLib.ahk"


class shop extends baseFunc{

    ShopCash() {
;        if (ok := FindText(&X := "wait", &Y := 3, NikkeX + 0.250 * NikkeW . " ", NikkeY + 0.599 * NikkeH . " ", NikkeX + 0.250 * NikkeW + 0.027 * NikkeW . " ", NikkeY + 0.599 * NikkeH + 0.047 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("付费商店的图标"), , , , , , , TrueRatio, TrueRatio)) {
;            AddLog("点击付费商店")
;            FindText().Click(X, Y, "L")
;            Sleep 2000
;            if g_settings["ShopCashFree"] {
;                AddLog("领取免费珠宝")
;                while true {
;                    if (ok := FindText(&X := "wait", &Y := 2, NikkeX + 0.386 * NikkeW . " ", NikkeY + 0.632 * NikkeH . " ", NikkeX + 0.386 * NikkeW + 0.016 * NikkeW . " ", NikkeY + 0.632 * NikkeH + 0.025 * NikkeH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("灰色空心方框"), , , , , , , TrueRatio, TrueRatio)) {
;                        AddLog("发现日服特供的框")
;                        FindText().Click(X, Y, "L")
;                        Sleep 1000
;                        if (ok := FindText(&X := "wait", &Y := 3, NikkeX, NikkeY, NikkeX + NikkeW, NikkeY + NikkeH, 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , 0, , , , , TrueRatio, TrueRatio)) {
;                            AddLog("点击确认")
;                            FindText().Click(X, Y, "L")
;                        }
;                    }
;                    else if (ok := FindText(&X, &Y, NikkeX + 0.040 * NikkeW . " ", NikkeY + 0.178 * NikkeH . " ", NikkeX + 0.040 * NikkeW + 0.229 * NikkeW . " ", NikkeY + 0.178 * NikkeH + 0.080 * NikkeH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("礼物的下半"), , , , , , , TrueRatio, TrueRatio)) {
;                        Sleep 500
;                        AddLog("点击一级页面")
;                        FindText().Click(X + 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                        Sleep 500
;                    }
;                    else break
;                }
;                while (ok := FindText(&X := "wait", &Y := 3, NikkeX + 0.002 * NikkeW . " ", NikkeY + 0.249 * NikkeH . " ", NikkeX + 0.002 * NikkeW + 0.367 * NikkeW . " ", NikkeY + 0.249 * NikkeH + 0.062 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , 1, TrueRatio, TrueRatio)) {
;                    AddLog("点击二级页面")
;                    FindText().Click(X - 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                    Sleep 1000
;                    if (ok := FindText(&X := "wait", &Y := 1, NikkeX + 0.002 * NikkeW . " ", NikkeY + 0.249 * NikkeH . " ", NikkeX + 0.002 * NikkeW + 0.367 * NikkeW . " ", NikkeY + 0.249 * NikkeH + 0.062 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红底的N图标"), , , , , , , TrueRatio, TrueRatio)) {
;                        AddLog("移除N标签")
;                        FindText().Click(X, Y, "L")
;                        Sleep 1000
;                        UserClick(238, 608, TrueRatio)
;                        Sleep 1000
;                    }
;                    if (ok := FindText(&X := "wait", &Y := 1, NikkeX + 0.089 * NikkeW . " ", NikkeY + 0.334 * NikkeH . " ", NikkeX + 0.089 * NikkeW + 0.019 * NikkeW . " ", NikkeY + 0.334 * NikkeH + 0.034 * NikkeH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("红点"), , , , , , 5, TrueRatio, TrueRatio)) {
;                        AddLog("点击三级页面")
;                        FindText().Click(X - 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                        Sleep 1000
;                        Confirm
;                        Sleep 500
;                        Confirm
;                    }
;                    if (ok := FindText(&X, &Y, NikkeX, NikkeY, NikkeX + NikkeW, NikkeY + NikkeH, 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("白色的叉叉"), , , , , , , TrueRatio, TrueRatio)) {
;                        FindText().Click(X, Y, "L")
;                        AddLog("检测到白色叉叉，尝试重新执行任务")
;                        BackToHall
;                        ShopCash
;                    }
;                }
;                else {
;                    AddLog("奖励已全部领取")
;                }
;            }
;            if g_settings["ShopCashFreePackage"] {
;                AddLog("领取免费礼包")
;                if (ok := FindText(&X := "wait", &Y := 1, NikkeX + 0.003 * NikkeW . " ", NikkeY + 0.180 * NikkeH . " ", NikkeX + 0.003 * NikkeW + 0.266 * NikkeW . " ", NikkeY + 0.180 * NikkeH + 0.077 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , TrueRatio, TrueRatio)) {
;                    AddLog("点击一级页面")
;                    FindText().Click(X - 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                    Sleep 1000
;                    if (ok := FindText(&X := "wait", &Y := 3, NikkeX + 0.010 * NikkeW . " ", NikkeY + 0.259 * NikkeH . " ", NikkeX + 0.010 * NikkeW + 0.351 * NikkeW . " ", NikkeY + 0.259 * NikkeH + 0.051 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , TrueRatio, TrueRatio)) {
;                        AddLog("点击二级页面")
;                        FindText().Click(X - 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                        Sleep 1000
;                        ;把鼠标移动到商品栏
;                        UserMove(1918, 1060, TrueRatio)
;                        Send "{WheelUp 3}"
;                        Sleep 1000
;                    }
;                    if (ok := FindText(&X := "wait", &Y := 3, NikkeX + 0.332 * NikkeW . " ", NikkeY + 0.443 * NikkeH . " ", NikkeX + 0.332 * NikkeW + 0.327 * NikkeW . " ", NikkeY + 0.443 * NikkeH + 0.466 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , TrueRatio, TrueRatio)) {
;                        AddLog("点击三级页面")
;                        FindText().Click(X - 20 * TrueRatio, Y + 20 * TrueRatio, "L")
;                        Sleep 1000
;                        Confirm
;                    }
;                }
;                AddLog("奖励已全部领取")
;            }
;            if g_settings["ClearRed"] {
;                while (ok := FindText(&X := "wait", &Y := 1, NikkeX + 0.001 * NikkeW . " ", NikkeY + 0.191 * NikkeH . " ", NikkeX + 0.001 * NikkeW + 0.292 * NikkeW . " ", NikkeY + 0.191 * NikkeH + 0.033 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红底的N图标"), , , , , , , 0.83 * TrueRatio, 0.83 * TrueRatio)) {
;                    FindText().Click(X, Y, "L")
;                    Sleep 1000
;                    while (ok := FindText(&X, &Y, NikkeX + 0.005 * NikkeW . " ", NikkeY + 0.254 * NikkeH . " ", NikkeX + 0.005 * NikkeW + 0.468 * NikkeW . " ", NikkeY + 0.254 * NikkeH + 0.031 * NikkeH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红底的N图标"), , , , , , , TrueRatio, TrueRatio)) {
;                        FindText().Click(X, Y, "L")
;                        Sleep 1000
;                        UserClick(208, 608, TrueRatio)
;                        Sleep 1000
;                        UserClick(62, 494, TrueRatio)
;                    }
;                }
;            }
;        }
;        BackToHall
    }

    func2(){
        MsgBox "Exec shop Func2"
    }

    init(mainGui, optStr){
        this.addCheckRow(mainGui,"付费商店免费珠宝",optStr, this.ShopCash)
        this.addCheckRow(mainGui,"Shop Func2","",this.func2)
    }
} 