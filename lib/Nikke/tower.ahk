#Requires AutoHotkey v2.0
#Include "..\helper.ahk"
#Include "..\baseFunc.ahk"
#Include "..\3rd\FindText.ahk"

curTowerFail := false

class tower extends baseFunc{
    

    TowerCompany() {
        enterArk
        AddLog("开始任务：企业塔", "Fuchsia")
        while (ok := FindText(&X, &Y, nikkePosX + (0.539 + 0.021 * nikkeServer) * nikkePosW . " ", nikkePosY + (0.373 + 0.05 * nikkeServer) * nikkePosH . " ", nikkePosX + (0.539 + 0.021 * nikkeServer) * nikkePosW + 0.066 * nikkePosW . " ", nikkePosY + (0.373 + 0.05 * nikkeServer) * nikkePosH + 0.031 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔的无限"), , , , , , , zoomW, zoomH)) {
            AddLog("进入无限之塔")
            FindText().Click(X, Y - 50 * zoomH, "L")
        }
        if (ok := FindText(&X := "wait", &Y := 5, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.007 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("圈中的感叹号"), , 0, , , , , zoomW, zoomH)) {
            AddLog("已进入无限之塔")
            Sleep 1000
        }
        else {
            AddLog("进入无限之塔失败，跳过任务", "MAROON")
            return
        }
        TowerArray := []
        loop 4 {
            if (!nikkeServer && ok := FindText(&X, &Y, nikkePosX + 0.356 * nikkePosW + 270 * zoomW * (A_Index - 1) . " ", nikkePosY + 0.521 * nikkePosH . " ", nikkePosX + 0.356 * nikkePosW + 0.070 * nikkePosW + 270 * zoomW * (A_Index - 1) . " ", nikkePosY + 0.521 * nikkePosH + 0.034 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔·OPEN"), , , , , , , zoomW, zoomH)) {
                Status := "开放中"
            }
            if (nikkeServer && ok := FindText(&X, &Y, nikkePosX + 0.356 * nikkePosW + 270 * zoomW * (A_Index - 1) . " ", nikkePosY + 0.521 * nikkePosH . " ", nikkePosX + 0.356 * nikkePosW + 0.070 * nikkePosW + 270 * zoomW * (A_Index - 1) . " ", nikkePosY + 0.521 * nikkePosH + 0.034 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔·开启"), , , , , , , zoomW * 1.5, zoomH * 1.5)) {
                Status := "开放中"
            }
            else Status := "未开放"
            switch A_Index {
                case 1: Tower := "极乐净土之塔"
                case 2: Tower := "米西利斯之塔"
                case 3: Tower := "泰特拉之塔"
                case 4: Tower := "朝圣者/超标准之塔"
            }
            if Status = "开放中" {
                TowerArray.Push(Tower)
                AddLog(Tower "-" Status, "Green")
            }
            else AddLog(Tower "-" Status, "Gray")
        }
        if (
            (!nikkeServer && ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.357 * nikkePosW . " ", nikkePosY + 0.518 * nikkePosH . " ", nikkePosX + 0.357 * nikkePosW + 0.287 * nikkePosW . " ", nikkePosY + 0.518 * nikkePosH + 0.060 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔·OPEN"), , , , , , 5, zoomW, zoomH)) ||
            (nikkeServer && ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.357 * nikkePosW . " ", nikkePosY + 0.518 * nikkePosH . " ", nikkePosX + 0.357 * nikkePosW + 0.287 * nikkePosW . " ", nikkePosY + 0.518 * nikkePosH + 0.060 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔·开启"), , , , , , 5, zoomW*1.5, zoomH*1.5))) {
            count := ok.Length
            Sleep 1000
            FindText().Click(X, Y + 100 * zoomH, "L")
            if nikkeServer
                Sleep 4500
            else
                Sleep 1000
            ; 添加变量跟踪当前关卡
            TowerIndex := 1
            ; 修改循环条件
            while (TowerIndex <= count) {
                Tower := TowerArray[TowerIndex]
                battleCount := 0
                while battleCount < 3 {
                    AddLog("尝试进入" Tower)
                    if (
                        (!nikkeServer &&ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.426 * nikkePosW . " ", nikkePosY + 0.405 * nikkePosH . " ", nikkePosX + 0.426 * nikkePosW + 0.025 *  nikkePosW . " ", nikkePosY + 0.405 * nikkePosH + 0.024 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("STAGE"), , , , , , , zoomW, zoomH)) ||
                        (nikkeServer && ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.357 * nikkePosW . " ", nikkePosY + 0.667 * nikkePosH . " ", nikkePosX + 0.357 * nikkePosW + 0.02 * nikkePosW . " ", nikkePosY + 0.667 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("CN_AIM"), , , , , , , zoomW * 1.5, zoomH * 1.5))) {

                        AddLog("已进入" Tower "的内部")
                        Sleep 1000
                
                        if(!nikkeServer)
                            FindText().Click(X + 100 * zoomW, Y, "L")
                        enterBattle
                        global curTowerFail
                        battleSettlement

                        if (curTowerFail) {
                            AddLog(Tower "战斗失败，返回", "Red")
                            Sleep 3000
                            
                            back
                            break
                        }
                        battleCount++
                    }
                    else if(nikkeServer && ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.912 * nikkePosW . " ", nikkePosY + 0.931 * nikkePosH . " ", nikkePosX + 0.912 * nikkePosW + 0.02 * nikkePosW . " ", nikkePosY + 0.931 * nikkePosH + 0.026 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("CN_塔排名"), , , , , , , zoomW * 1.5, zoomH * 1.5)) {
                        AddLog(Tower "已完成")
                        break
                    } else {
                        RefuseSale
                    }
                }
                TowerIndex++
                ; 检查是否已完成所有关卡
                if (TowerIndex > count) {
                    break
                }
                if (!curTowerFail) {
                    AddLog(Tower "战斗完成，返回下一个")
                }
                else{
                    curTowerFail := false
                }
                ; 点向右的箭头进入下一关
                if (ok := FindText(&X := "wait", &Y := 5, nikkePosX + (0.569 - 0.015 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.833 * nikkePosH . " ", nikkePosX + (0.569 - 0.015 * nikkeServer) * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.833 * nikkePosH + 0.069 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("无限之塔·向右的箭头"), , , , , , , zoomW, zoomH)) {
                    Sleep 3000
                    FindText().Click(X, Y, "L")
                }
                Sleep 1000
            }
            AddLog("所有塔都打过了")
        }
        loop 2 {
            back
            Sleep 2000
        }
    }

    init(mainGui, optStr){
        this.addCheckRow(mainGui,"爬企业塔",optStr, this.TowerCompany)
    }
}