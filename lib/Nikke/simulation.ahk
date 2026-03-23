#Requires AutoHotkey v2.0
#Include "..\baseFunc.ahk"
#Include "..\helper.ahk"
#Include "..\3rd\FindText.ahk"

global nikkeServer

class simulation extends baseFunc{
    static normal(){
        enterArk
        AddLog("开始任务：模拟室", "Fuchsia")
        AddLog("查找模拟室入口")

        while (ok := FindText(&X, &Y, nikkePosX + 0.370 * nikkePosW . " ", nikkePosY + (0.544 + 0.05 * nikkeServer) * nikkePosH . " ", nikkePosX + 0.370 * nikkePosW + 0.069 * nikkePosW . " ", nikkePosY + (0.544 + 0.05 * nikkeServer) * nikkePosH + 0.031 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("模拟室"), , 0, , , , , zoomW, zoomH)) {
            AddLog("进入模拟室")
            FindText().Click(X, Y - 50 * zoomH, "L")
            Sleep 1000
        }
        while true {
            if (ok := FindText(&X, &Y, nikkePosX + 0.897 * nikkePosW . " ", nikkePosY + 0.063 * nikkePosH . " ", nikkePosX + 0.897 * nikkePosW + 0.102 * nikkePosW . " ", nikkePosY + 0.063 * nikkePosH + 0.060 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("结束模拟的图标"), , 0, , , , , zoomW, zoomH)) {
                MsgBox("请手动结束模拟后重新运行该任务")
                Pause
            }
            if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.442 * nikkePosW . " ", nikkePosY + 0.535 * nikkePosH . " ", nikkePosX + 0.442 * nikkePosW + 0.118 * nikkePosW . " ", nikkePosY + 0.535 * nikkePosH + 0.101 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("开始模拟的开始"), , 0, , , , , zoomW, zoomH)) {
                AddLog("点击开始模拟")
                FindText().Click(X + 30 * zoomW, Y, "L")
                Sleep 500
                break
            }
            else idleClick
        }
        ;if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.373 * nikkePosW . " ", nikkePosY + 0.695 * nikkePosH . " ", nikkePosX + 0.373 * nikkePosW + 0.104 * nikkePosW . " ", nikkePosY + 0.;695 * nikkePosH + 0.058 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("模拟室·已通关"), , , , , , , zoomW, zoomH)) {
        ;    AddLog("模拟已通关，跳过该任务", "Olive")
        ;    sleep 1000
        ;    idleClick
        ;    return
        ;}
        Directly := false
        while !(ok := FindText(&X, &Y, nikkePosX + (0.469 - 0.032 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.761 * nikkePosH . " ", nikkePosX + (0.469 - 0.032 * nikkeServer) * nikkePosW + 0.037 * nikkePosW . " ", nikkePosY + 0.761 * nikkePosH + 0.047 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("模拟室·蓝色的开关"), , , , , , , zoomW, zoomH)) {
            scaledClick(1850, 1710)
            Sleep 500
            Directly := false
            if A_Index >= 3 {
                Directly := true
                break
            }
        }
        if !Directly {
            if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.501 * nikkePosW . " ", nikkePosY + 0.830 * nikkePosH . " ", nikkePosX + 0.501 * nikkePosW + 0.150 * nikkePosW . " ", nikkePosY + 0.830 * nikkePosH + 0.070 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("快速模拟的图标"), , 0, , , , , zoomW, zoomH)) {
                AddLog("点击快速模拟")
                Sleep 500
                FindText().Click(X + 100 * zoomW, Y, "L")
            }
            else {
                AddLog("没有解锁快速模拟，跳过该任务", "Olive")
                return
            }
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.474 * nikkePosW . " ", nikkePosY + 0.521 * nikkePosH . " ", nikkePosX + 0.474 * nikkePosW + 0.052 * nikkePosW . " ", nikkePosY + 0.521 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("模拟室·不再显示"), , 0, , , , , zoomW, zoomH)) {
                AddLog("点击不再显示")
                Sleep 500
                FindText().Click(X, Y, "L")
                Sleep 500
                if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.441 * nikkePosW . " ", nikkePosY + 0.602 * nikkePosH . " ", nikkePosX + 0.441 * nikkePosW + 0.119 * nikkePosW . " ", nikkePosY + 0.602 * nikkePosH + 0.050 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW, zoomH)) {
                    AddLog("确认快速模拟指南")
                    Sleep 500
                    FindText().Click(X, Y, "L")
                }
            }
            if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.428 * nikkePosW . " ", nikkePosY + 0.883 * nikkePosH . " ", nikkePosX + 0.428 * nikkePosW + 0.145 * nikkePosW . " ", nikkePosY + 0.883 * nikkePosH + 0.069 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("跳过增益效果选择的图标"), , 0, , , , , zoomW, zoomH)) {
                Sleep 500
                AddLog("跳过增益选择")
                FindText().Click(X + 100 * zoomW, Y, "L")
                Sleep 1000
            }
            enterBattle
            if BattleActive = 0 {
                if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.485 * nikkePosW . " ", nikkePosY + 0.681 * nikkePosH . " ", nikkePosX + 0.485 * nikkePosW + 0.030 * nikkePosW . " ", nikkePosY + 0.681 * nikkePosH + 0.048 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW * 1.25, zoomH * 1.25)) {
                    FindText().Click(X, Y, "L")
                    enterBattle
                }
            }
            BattleSettlement
        }
        if (ok := FindText(&X := "wait", &Y := 5, nikkePosX + 0.364 * nikkePosW . " ", nikkePosY + 0.323 * nikkePosH . " ", nikkePosX + 0.364 * nikkePosW + 0.272 * nikkePosW . " ", nikkePosY + 0.323 * nikkePosH + 0.558 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("模拟结束的图标"), , , , , , , zoomW, zoomH)) {
            AddLog("点击模拟结束")
            Sleep 500
            FindText().Click(X + 50 * zoomW, Y, "L")
            Sleep 500
            FindText().Click(X + 50 * zoomW, Y, "L")
        }
        while !(ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
            idleClick
        }
    }

    init(mainGui, optStr){
        this.addCheckRow(this, mainGui,"普通模拟室", optStr, simulation.normal)
    }
}