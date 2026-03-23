#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\3rd\FindText.ahk"
#Include "..\3rd\PicLib.ahk"
#Include "..\helper.ahk"

class arena extends baseFunc{

    AwardArena() {
        enterArk()
        AddLog("开始任务：竞技场收菜", "Fuchsia")
        AddLog("查找奖励")
        foundReward := false
        while (ok := FindText(&X, &Y, nikkePosX + (0.568 - 0.01 * nikkeServer) * nikkePosW . " ", nikkePosY + (0.443 + 0.06 * nikkeServer) * nikkePosH . " ", nikkePosX + (0.568 - 0.01 * nikkeServer) * nikkePosW + 0.015 * nikkePosW . " ", nikkePosY + (0.443 + 0.06 * nikkeServer) * nikkePosH + 0.031 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("竞技场·收菜的图标"), , , , , , , zoomW, zoomH)) {
            foundReward := true
            AddLog("点击奖励")
            FindText().Click(X + 30 * zoomW, Y, "L")
            Sleep 1000
        }
        if foundReward {
            while (ok := FindText(&X := "wait", &Y := 1, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW, zoomH)) {
                AddLog("点击领取")
                FindText().Click(X + 50 * zoomW, Y, "L")
                Sleep 500
            }
            AddLog("尝试确认并返回方舟大厅")
            while !(ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.014 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH . " ", nikkePosX + 0.014 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH + 0.021 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("左上角的方舟"), , , , , , , zoomW, zoomH)) {
                idleClick
            }
        }
        else AddLog("未找到奖励")
    }

    ;tag 新人竞技场
    ArenaRookie() {
        enterArk()
        enterArena()
        AddLog("开始任务：新人竞技场", "Fuchsia")
        AddLog("查找新人竞技场")
        while (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.372 * nikkePosW . " ", nikkePosY + 0.542 * nikkePosH . " ", nikkePosX + 0.372 * nikkePosW + 0.045 * nikkePosW . " ", nikkePosY + 0.542 * nikkePosH + 0.024 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("蓝色的新人"), , , , , , , zoomW, zoomH)) {
            AddLog("点击新人竞技场")
            FindText().Click(X + 20 * zoomW, Y, "L")
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
                AddLog("已进入新人竞技场")
                break
            }
            if A_Index > 3 {
                AddLog("新人竞技场未在开放期间，跳过任务")
                return
            }
        }
        AddLog("检测免费次数")
        skip := false
        while True {
            if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.578 * nikkePosW . " ", nikkePosY + 0.804 * nikkePosH . " ", nikkePosX + 0.578 * nikkePosW + 0.059 * nikkePosW . " ", nikkePosY + 0.804 * nikkePosH + 0.045 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("免费"), , , , , , , zoomW, zoomH)) {
                AddLog("有免费次数，尝试进入战斗")
                FindText().Click(X, Y + 10 * zoomH, "L")
            }
            else {
                AddLog("没有免费次数，尝试返回")
                break
            }
            if skip = false {
                Sleep 1000
                if (ok := FindText(&X, &Y, nikkePosX + 0.393 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH . " ", nikkePosX + 0.393 * nikkePosW + 0.081 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH + 0.041 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("ON"), , , , , , , zoomW, zoomH)) {
                    AddLog("快速战斗已开启")
                    skip := true
                }
                else if (ok := FindText(&X, &Y, nikkePosX + 0.393 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH . " ", nikkePosX + 0.393 * nikkePosW + 0.081 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH + 0.041 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("OFF"), , , , , , , zoomW, zoomH)) {
                    AddLog("有笨比没开快速战斗，帮忙开了！")
                    FindText().Click(X, Y, "L")
                }
            }
            enterBattle
            BattleSettlement
            while !(ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
                idleClick
            }
        }
        while (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
            back
            Sleep 1000
        }
        AddLog("已返回竞技场页面")
    }
    ;tag 特殊竞技场
    ArenaSpecial() {
        enterArk()
        enterArena()
        AddLog("开始任务：特殊竞技场", "Fuchsia")
        AddLog("查找特殊竞技场")
        while (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.516 * nikkePosW . " ", nikkePosY + 0.543 * nikkePosH . " ", nikkePosX + 0.516 * nikkePosW + 0.045 * nikkePosW . " ", nikkePosY + 0.543 * nikkePosH + 0.022 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("蓝色的特殊"), , , , , , , zoomW, zoomH)) {
            AddLog("点击特殊竞技场")
            FindText().Click(X + 20 * zoomW, Y, "L")
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomH, zoomH)) {
                AddLog("已进入特殊竞技场")
                break
            }
            if A_Index > 3 {
                AddLog("特殊竞技场未在开放期间，跳过任务")
                return
            }
        }
        AddLog("检测免费次数")
        skip := false
        while True {
            if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.578 * nikkePosW . " ", nikkePosY + 0.804 * nikkePosH . " ", nikkePosX + 0.578 * nikkePosW + 0.059 * nikkePosW . " ", nikkePosY + 0.804 * nikkePosH + 0.045 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("免费"), , , , , , , zoomW, zoomH)) {
                AddLog("有免费次数，尝试进入战斗")
                FindText().Click(X, Y + 10 * zoomH, "L")
                Sleep 1000
            }
            else {
                AddLog("没有免费次数，尝试返回")
                break
            }
            if skip = false {
                Sleep 1000
                if (ok := FindText(&X, &Y, nikkePosX + 0.393 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH . " ", nikkePosX + 0.393 * nikkePosW + 0.081 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH + 0.041 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("ON"), , , , , , , zoomW, zoomH)) {
                    AddLog("快速战斗已开启")
                    skip := true
                }
                else if (ok := FindText(&X, &Y, nikkePosX + 0.393 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH . " ", nikkePosX + 0.393 * nikkePosW + 0.081 * nikkePosW . " ", nikkePosY + 0.815 * nikkePosH + 0.041 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("OFF"), , , , , , , zoomW, zoomH)) {
                    AddLog("有笨比没开快速战斗，帮忙开了！")
                    FindText().Click(X, Y, "L")
                }
            }
            enterBattle
            BattleSettlement
            while !(ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
                idleClick
            }
        }
        while (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
            back
            Sleep 1000
        }
        AddLog("已返回竞技场页面")
    }
    ;tag 冠军竞技场
    ArenaChampion() {
        enterArk()
        enterArena()
        AddLog("开始任务：冠军竞技场", "Fuchsia")
        AddLog("查找冠军竞技场")
        if (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.567 * nikkePosW . " ", nikkePosY + 0.621 * nikkePosH . " ", nikkePosX + 0.567 * nikkePosW + 0.075 * nikkePosW . " ", nikkePosY + 0.621 * nikkePosH + 0.047 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            AddLog("已找到红点")
            Sleep 1000
        }
        else {
            AddLog("未在应援期间")
            back
            return
        }
        while (ok := FindText(&X := "wait", &Y := 3, nikkePosX + 0.373 * nikkePosW . " ", nikkePosY + 0.727 * nikkePosH . " ", nikkePosX + 0.373 * nikkePosW + 0.255 * nikkePosW . " ", nikkePosY + 0.727 * nikkePosH + 0.035 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("内部的紫色应援"), , , , , , , zoomW, zoomH)) {
            AddLog("已找到二级应援文本")
            FindText().Click(X, Y - 200 * zoomH, "L")
            Sleep 1000
        }
        else {
            AddLog("未在应援期间")
            back
            Sleep 2000
            return
        }
        while !(ok := FindText(&X, &Y, nikkePosX + 0.443 * nikkePosW . " ", nikkePosY + 0.869 * nikkePosH . " ", nikkePosX + 0.443 * nikkePosW + 0.117 * nikkePosW . " ", nikkePosY + 0.869 * nikkePosH + 0.059 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("晋级赛内部的应援"), , , , , , , zoomW, zoomH)) {
            idleClick
            Sleep 1000
            if A_Index > 10 {
                AddLog("无法应援", "red")
                back
                Sleep 2000
                return
            }
        }
        AddLog("已找到三级应援文本")
        FindText().Click(X, Y, "L")
        Sleep 4000
        if UserCheckColor([1926], [1020], ["0xF2762B"], zoomH) {
            AddLog("左边支持的人多")
            scaledClick(1631, 1104)
        }
        else {
            AddLog("右边支持的人多")
            scaledClick(2097, 1096)
        }
        Sleep 1000
        if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.503 * nikkePosW . " ", nikkePosY + 0.837 * nikkePosH . " ", nikkePosX + 0.503 * nikkePosW + 0.096 * nikkePosW . " ", nikkePosY + 0.837 * nikkePosH + 0.058 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 1000
        }
        loop 2 {
            back
            Sleep 2000
        }
    }
    
    init(mainGui, optStr){
        this.addCheckRow(this, mainGui,"竞技场收菜",optStr, this.AwardArena)
        this.addCheckRow(this, mainGui,"新人竞技场","",this.ArenaRookie)
        this.addCheckRow(this, mainGui,"特殊竞技场","",this.ArenaSpecial)
    }
} 