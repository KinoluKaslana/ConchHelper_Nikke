#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\3rd\FindText.ahk"
#Include "..\3rd\PicLib.ahk"
#Include "..\helper.ahk"
global nikkePosH, nikkePosW, nikkePosX, nikkePosY, zoomH, zoomW

class shop extends baseFunc{

    ShopCash() {
        if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.250 * nikkePosW . " ", nikkePosY + 0.599 * nikkePosH . " ", nikkePosX + 0.250 * nikkePosW + 0.027 * nikkePosW . " ", nikkePosY + 0.599 * nikkePosH + 0.047 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("付费商店的图标"), , , , , , , zoomW, zoomH)) {
            ;AddLog("点击付费商店")
            FindText().Click(X, Y, "L")
            Sleep 2000
            if 1 {
                ;AddLog("领取免费珠宝")
                while true {
                    if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.386 * nikkePosW . " ", nikkePosY + 0.632 * nikkePosH . " ", nikkePosX + 0.386 * nikkePosW + 0.016 * nikkePosW . " ", nikkePosY + 0.632 * nikkePosH + 0.025 * nikkePosH . " ", 0.2 * 1, 0.2 * 1, FindText().PicLib("灰色空心方框"), , , , , , , zoomW, zoomH)) {
                        ;AddLog("发现日服特供的框")
                        FindText().Click(X, Y, "L")
                        Sleep 1000
                        if (ok := FindText(&X := "wait", &Y := 3, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.3 * 1, 0.3 * 1, FindText().PicLib("带圈白勾"), , 0, , , , , zoomH, zoomH)) {
                            ;AddLog("点击确认")
                            FindText().Click(X, Y, "L")
                        }
                    }
                    else if (ok := FindText(&X, &Y, nikkePosX + 0.040 * nikkePosW . " ", nikkePosY + 0.178 * nikkePosH . " ", nikkePosX + 0.040 * nikkePosW + 0.229 * nikkePosW . " ", nikkePosY + 0.178 * nikkePosH + 0.080 * nikkePosH . " ", 0.2 * 1, 0.2 * 1, FindText().PicLib("礼物的下半"), , , , , , , zoomW, zoomH)) {
                        Sleep 500
                        ;AddLog("点击一级页面")
                        FindText().Click(X + 20 * zoomW, Y + 20 * zoomH, "L")
                        Sleep 500
                    }
                    else break
                }
                while (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.002 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH . " ", nikkePosX + 0.002 * nikkePosW + 0.367 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH + 0.062 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , 1, zoomW, zoomH)) {
                    ;AddLog("点击二级页面")
                    FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                    Sleep 1000
                    if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.002 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH . " ", nikkePosX + 0.002 * nikkePosW + 0.367 * nikkePosW . " ", nikkePosY + 0.249 * nikkePosH + 0.062 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , zoomW, zoomH)) {
                        ;AddLog("移除N标签")
                        FindText().Click(X, Y, "L")
                        Sleep 1000
                        UserClick(238, 608, zoomH)
                        Sleep 1000
                    }
                    if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.089 * nikkePosW . " ", nikkePosY + 0.334 * nikkePosH . " ", nikkePosX + 0.089 * nikkePosW + 0.019 * nikkePosW . " ", nikkePosY + 0.334 * nikkePosH + 0.034 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("红点"), , , , , , 5, zoomW, zoomH)) {
                        ;AddLog("点击三级页面")
                        FindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                        Sleep 1000
                        Confirm
                        Sleep 500
                        Confirm
                    }
                    if (ok := FindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.2 * 1, 0.2 * 1, FindText().PicLib("白色的叉叉"), , , , , , , zoomW, zoomH)) {
                        FindText().Click(X, Y, "L")
                        ;AddLog("检测到白色叉叉，尝试重新执行任务")
                        BackToHall
                        this.ShopCash
                    }
                }
                else {
                    ;AddLog("奖励已全部领取")
                }
            }
            if 1 {
                ;AddLog("领取免费礼包")
                if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.180 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.266 * nikkePosW . " ", nikkePosY + 0.180 * nikkePosH + 0.077 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                    ;AddLog("点击一级页面")
                    FindText().Click(X - 20 * zoomH, Y + 20 * zoomH, "L")
                    Sleep 1000
                    if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.010 * nikkePosW . " ", nikkePosY + 0.259 * nikkePosH . " ", nikkePosX + 0.010 * nikkePosW + 0.351 * nikkePosW . " ", nikkePosY + 0.259 * nikkePosH + 0.051 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                        ;AddLog("点击二级页面")
                        FindText().Click(X - 20 * zoomH, Y + 20 * zoomH, "L")
                        Sleep 1000
                        ;把鼠标移动到商品栏
                        UserMove(1918, 1060, zoomH)
                        Send "{WheelUp 3}"
                        Sleep 1000
                    }
                    if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.332 * nikkePosW . " ", nikkePosY + 0.443 * nikkePosH . " ", nikkePosX + 0.332 * nikkePosW + 0.327 * nikkePosW . " ", nikkePosY + 0.443 * nikkePosH + 0.466 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                        ;AddLog("点击三级页面")
                        FindText().Click(X - 20 * zoomH, Y + 20 * zoomH, "L")
                        Sleep 1000
                        Confirm
                    }
                }
                ;AddLog("奖励已全部领取")
            }
            if 1 {
                while (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.001 * nikkePosW . " ", nikkePosY + 0.191 * nikkePosH . " ", nikkePosX + 0.001 * nikkePosW + 0.292 * nikkePosW . " ", nikkePosY + 0.191 * nikkePosH + 0.033 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , 0.83 * zoomW, 0.83 * zoomH)) {
                    FindText().Click(X, Y, "L")
                    Sleep 1000
                    while (ok := FindText(&X, &Y, nikkePosX + 0.005 * nikkePosW . " ", nikkePosY + 0.254 * nikkePosH . " ", nikkePosX + 0.005 * nikkePosW + 0.468 * nikkePosW . " ", nikkePosY + 0.254 * nikkePosH + 0.031 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("红底的N图标"), , , , , , , zoomW, zoomH)) {
                        FindText().Click(X, Y, "L")
                        Sleep 1000
                        UserClick(208, 608, zoomH)
                        Sleep 1000
                        UserClick(62, 494, zoomH)
                    }
                }
            }
        }
        BackToHall
    }

    func2(){
        MsgBox "Exec shop Func2"
    }

    init(mainGui, optStr){
        this.addCheckRow(mainGui,"付费商店免费珠宝",optStr, this.ShopCash)
        this.addCheckRow(mainGui,"Shop Func2","",this.func2)
    }
} 