#Requires AutoHotkey v2.0

#Include <log>
#Include "Nikke\processcatch.ahk"
#Include "3rd\Gdip_Toolbox.ahk"

picLibClientW := 3840
picLibClientH := 2160
PicTolerance := 1

zoomW := 1
zoomH := 1

changeServer(guiObj,event){
    global nikkeServer
    if(guiObj.Text == "国服")
        nikkeServer := 1
    if(guiObj.Text == "国际服")
        nikkeServer := 0
}

nikkePosWindowInfoRefresh(textGuiObj){
    global processHWND, nikkePosX, nikkePosY, nikkePosW, nikkePosH, zoomW, zoomH
    getnikkePosHWND()
    getNikkePos()
    zoomW := nikkePosW / picLibClientW
    zoomH := nikkePosH / picLibClientH
    if (processHWND){
        textGuiObj.Text := "找到窗口"
    }
    else{
        textGuiObj.Text := "没找到窗口"
    }
}

scaledMove(x, y){
    CoordMode "Mouse", "Screen"
    Send "{Click " Round(x * zoomW) + nikkePosX " " Round(y*zoomH) + nikkePosY " 0}"
}

scaledClick(x, y){
    scaledMove(x, y)
    Click
}

idleClick(){
    global processHWND
    ;点击左下角 280 1360处
    WinActivate processHWND
    scaledClick(420, 2040)
}

selfFindText(params*){
    debug := false
    if(params.Length == 0){
        return FindText()
    }
    if(debug)
        createOutline(params[3],params[4],params[5],params[6])
    return FindText(params*)
}

refuseSale() {
    if (ok := FindText(&X, &Y, nikkePosX + 0.438 * nikkePosW . " ", nikkePosY + 0.853 * nikkePosH . " ", nikkePosX + 0.438 * nikkePosW + 0.124 * nikkePosW . " ", nikkePosY + 0.853 * nikkePosH + 0.048 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("黄色的小时"), , , , , , , zoomW, zoomH)) {
        scaledClick(333, 2041)
        Sleep 500
        if (ok := FindText(&X, &Y, nikkePosX + 0.504 * nikkePosW . " ", nikkePosY + 0.594 * nikkePosH . " ", nikkePosX + 0.504 * nikkePosW + 0.127 * nikkePosW . " ", nikkePosY + 0.594 * nikkePosH + 0.065 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("带圈白勾"), , 0, , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 500
        }
    }
}

back() {
    if (ok := FindText(&X, &Y, nikkePosX + 0.658 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH . " ", nikkePosX + 0.658 * nikkePosW + 0.040 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH + 0.066 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("方舟的图标"), , 0, , , , , zoomW, zoomH)) {
        return
    }
    ; AddLog("返回")
    Send "{Esc}"
    if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.518 * nikkePosW . " ", nikkePosY + 0.609 * nikkePosH . " ", nikkePosX + 0.518 * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.609 * nikkePosH + 0.033 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
        Sleep 1000
        FindText().Click(X, Y, "L")
    }
    Send "{]}"
    Sleep 500
}

backHall(){
    while true {
        if (ok := FindText(&X, &Y, nikkePosX + 0.658 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH . " ", nikkePosX + 0.658 * nikkePosW + 0.040 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH + 0.066 * nikkePosH . " ", 0.4 * 1, 0.4 * 1, FindText().PicLib("方舟的图标"), , 0, , , , , zoomW, zoomH)) {
            ; 点右上角的公告图标
            scaledClick(3568, 90)
            Sleep 500
            if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.477 * nikkePosW . " ", nikkePosY + 0.082 * nikkePosH . " ", nikkePosX + 0.477 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.082 * nikkePosH + 0.042 * nikkePosH . " ", 0.3 * 1, 0.3 * 1, FindText().PicLib("公告的图标"), , , , , , , zoomW, zoomH)) {
                ; AddLog("已返回大厅")
                loop 3 {
                    idleClick
                }
                Sleep 500
                break
            }
            else refuseSale
        }
        else {
            ; 点左下角的小房子的位置
            scaledClick(333, 2041)
            Sleep 500
            Send "{]}"
            refuseSale
        }
        if A_Index > 10 {
            scaledClick(1924, 1968)
            Sleep 500
        }
        if A_Index > 50 {
            MsgBox ("返回大厅失败，程序已中止")
            Pause
        }
    }
    Sleep 1000
}

;tag 进入方舟
enterArk() {
    ;AddLog("进入方舟")
    while True {
        Sleep 500
        if (ok := FindText(&X, &Y, nikkePosX + 0.014 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH . " ", nikkePosX + 0.014 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH + 0.021 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("左上角的方舟"), , , , , , , zoomW, zoomH)) {
            break
        }
        if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.658 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH . " ", nikkePosX + 0.658 * nikkePosW + 0.040 * nikkePosW . " ", nikkePosY + 0.639 * nikkePosH + 0.066 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("方舟的图标"), , 0, , , , , zoomW, zoomH)) {
            FindText().Click(X + 50 * zoomW, Y, "L") ;找得到就尝试进入
        }
        if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.014 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH . " ", nikkePosX + 0.014 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.026 * nikkePosH + 0.021 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("左上角的方舟"), , , , , , , zoomW, zoomH)) {
            break
        }
        else backHall() ;找不到就先返回大厅
    }
    Sleep 2000
}

;tag 进入竞技场
enterArena() {
    if (ok := selfFindText(&X, &Y, nikkePosX + 0.001 * nikkePosW . " ", nikkePosY + 0.002 * nikkePosH . " ", nikkePosX + 0.001 * nikkePosW + 0.060 * nikkePosW . " ", nikkePosY + 0.002 * nikkePosH + 0.060 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("左上角的竞技场"), , , , , , , zoomW, zoomH)) {
        return
    }
    while (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + (0.554 - 0.014 * nikkeServer) * nikkePosW . " ", nikkePosY + (0.640 + 0.071 * nikkeServer) * nikkePosH . " ", nikkePosX + (0.554 - 0.014 * nikkeServer) * nikkePosW + 0.068 * nikkePosW . " ", nikkePosY + (0.640 + 0.071 * nikkeServer) * nikkePosH + 0.029 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib(nikkeServer ? "CN_方舟·竞技场" : "方舟·竞技场"), , , , , , , zoomW * (nikkeServer ? 1.5 : 1), zoomH * (nikkeServer ? 1.5 : 1))) {
        AddLog("点击竞技场")
        selfFindText().Click(X, Y - 50 * zoomH, "L")
    }
    while !(ok := selfFindText(&X, &Y, nikkePosX + 0.001 * nikkePosW . " ", nikkePosY + 0.002 * nikkePosH . " ", nikkePosX + 0.001 * nikkePosW + 0.060 * nikkePosW . " ", nikkePosY + 0.002 * nikkePosH + 0.060 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("左上角的竞技场"), , , , , , , zoomW, zoomH)) {
        idleClick
    }
    AddLog("进入竞技场")
    Sleep 1000
}

;tag 进入前哨基地
enterOutpost() {
    ;AddLog("进入前哨基地")
    while True {
        Sleep 500
        if (ok := FindText(&X, &Y, nikkePosX + 0.004 * nikkePosW . " ", nikkePosY + 0.020 * nikkePosH . " ", nikkePosX + 0.004 * nikkePosW + 0.043 * nikkePosW . " ", nikkePosY + 0.020 * nikkePosH + 0.034 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("左上角的前哨基地"), , , , , , , zoomW, zoomH)) {
            break
        }
        if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.240 * nikkePosW . " ", nikkePosY + 0.755 * nikkePosH . " ", nikkePosX + 0.240 * nikkePosW + 0.048 * nikkePosW . " ", nikkePosY + 0.755 * nikkePosH + 0.061 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("前哨基地的图标"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L") ;找得到就尝试进入
        }
        if (ok := FindText(&X := "wait", &Y := 10, nikkePosX + 0.004 * nikkePosW . " ", nikkePosY + 0.020 * nikkePosH . " ", nikkePosX + 0.004 * nikkePosW + 0.043 * nikkePosW . " ", nikkePosY + 0.020 * nikkePosH + 0.034 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("左上角的前哨基地"), , , , , , , zoomW, zoomH)) {
            break
        }
        else backHall() ;找不到就先返回大厅
    }
    Sleep 2000
}

;tag 进入战斗
enterBattle() {
    ;是否能战斗
    global BattleActive
    ;是否能跳过动画
    global BattleSkip
    ;是否能快速战斗
    global QuickBattle
    QuickBattle := 0
    ; AddLog("尝试进入战斗")
    if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.506 * nikkePosW . " ", nikkePosY + 0.826 * nikkePosH . " ", nikkePosX + 0.506 * nikkePosW + 0.145 * nikkePosW . " ", nikkePosY + 0.826 * nikkePosH + 0.065 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("快速战斗的图标"), , , , , , , zoomW, zoomH)) {
        AddLog("点击快速战斗")
        FindText().Click(X + 50 * zoomW, Y, "L")
        BattleActive := 1
        QuickBattle := 1
        Sleep 500
        if (ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.553 * nikkePosW . " ", nikkePosY + 0.683 * nikkePosH . " ", nikkePosX + 0.553 * nikkePosW + 0.036 * nikkePosW . " ", nikkePosY + 0.683 * nikkePosH + 0.040 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("MAX"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 500
        }
        if (ok := FindText(&X, &Y, nikkePosX + 0.470 * nikkePosW . " ", nikkePosY + 0.733 * nikkePosH . " ", nikkePosX + 0.470 * nikkePosW + 0.157 * nikkePosW . " ", nikkePosY + 0.733 * nikkePosH + 0.073 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("进行战斗的进"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 500
        }
        BattleSkip := 0
    }
    else if (ok := FindText(&X, &Y, nikkePosX + 0.499 * nikkePosW . " ", nikkePosY + 0.786 * nikkePosH . " ", nikkePosX + 0.499 * nikkePosW + 0.155 * nikkePosW . " ", nikkePosY + 0.786 * nikkePosH + 0.191 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("进入战斗的进"), , , , , , , zoomW, zoomH)) {
        AddLog("点击进入战斗")
        BattleActive := 1
        BattleSkip := 1
        FindText().Click(X + 50 * zoomW, Y, "L")
        Sleep 500
    }
    else if (ok := FindText(&X, &Y, nikkePosX + 0.519 * nikkePosW . " ", nikkePosY + 0.831 * nikkePosH . " ", nikkePosX + 0.519 * nikkePosW + 0.134 * nikkePosW . " ", nikkePosY + 0.831 * nikkePosH + 0.143 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("灰色的进"), , , , , , , zoomW, zoomH)) {
        BattleActive := 2
    }
    else {
        BattleActive := 0
        AddLog("无法战斗")
    }
}
;tag 战斗结算
battleSettlement(currentVictory := 0, modes*) {
    global LastVictoryCount ; 声明要使用的全局变量
    Screenshot := false
    RedCircle := false
    Exit7 := false
    EventStory := false
    if (BattleActive = 0 or BattleActive = 2) {
        AddLog("由于无法战斗，跳过战斗结算")
        if BattleActive = 2 {
            Send "{Esc}"
        }
        LastVictoryCount := currentVictory ; 更新全局变量
        return
    }
    for mode in modes {
        switch mode {
            case "Screenshot":
            {
                Screenshot := true
                if BattleSkip := 1
                    AddLog("截图功能已启用", "Green")
            }
            case "RedCircle":
            {
                RedCircle := true
                if BattleSkip := 1
                    AddLog("红圈功能已启用", "Green")
            }
            case "Exit7":
            {
                Exit7 := true
                if BattleSkip := 1
                    AddLog("满7自动退出功能已启用", "Green")
            }
            case "EventStory":
            {
                EventStory := true
                if BattleSkip := 1
                    AddLog("剧情跳过功能已启用", "Green")
            }
            default: MsgBox "格式输入错误，你输入的是" mode
        }
    }
    AddLog("等待战斗结算")
    while true {
        if Exit7 {
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.512 * nikkePosW . " ", nikkePosY + 0.072 * nikkePosH . " ", nikkePosX + 0.512 * nikkePosW + 0.020 * nikkePosW . " ", nikkePosY + 0.072 * nikkePosH + 0.035 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("拦截战·红色框的7"), , , , , , , zoomW, zoomH)) {
                Send "{Esc}"
                if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.382 * nikkePosW . " ", nikkePosY + 0.890 * nikkePosH . " ", nikkePosX + 0.382 * nikkePosW + 0.113 * nikkePosW . " ", nikkePosY + 0.890 * nikkePosH + 0.067 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("放弃战斗的图标"), , , , , , , zoomW, zoomH)) {
                    Sleep 500
                    selfFindText().Click(X, Y, "L")
                    if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.518 * nikkePosW . " ", nikkePosY + 0.609 * nikkePosH . " ", nikkePosX + 0.518 * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.609 * nikkePosH + 0.033 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
                        Sleep 500
                        selfFindText().Click(X, Y, "L")
                    }
                    AddLog("满7自动退出")
                }
            }
        }
        if RedCircle {
            if (ok := selfFindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.12 * PicTolerance, 0.13 * PicTolerance, selfFindText().PicLib("红圈的上边缘黄边"), , 0, , , , , zoomW, zoomH)) {
                AddLog("检测到红圈的上边缘黄边")
                selfFindText().Click(X, Y + 70 * zoomH, 0)
                Sleep 100
                Click "down left"
                Sleep 700
                Click "up left"
                Sleep 100
            }
            if (ok := selfFindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.12 * PicTolerance, 0.13 * PicTolerance, selfFindText().PicLib("红圈的下边缘黄边"), , 0, , , , , zoomW, zoomH)) {
                AddLog("检测到红圈的下边缘黄边")
                selfFindText().Click(X, Y - 70 * zoomH, 0)
                Sleep 100
                Click "down left"
                Sleep 700
                Click "up left"
                Sleep 100
            }
            if (ok := selfFindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.12 * PicTolerance, 0.11 * PicTolerance, selfFindText().PicLib("红圈的左边缘黄边"), , 0, , , , , zoomW, zoomH)) {
                AddLog("检测到红圈的左边缘黄边")
                selfFindText().Click(X + 70 * zoomW, Y, 0)
                Sleep 100
                Click "down left"
                Sleep 700
                Click "up left"
                Sleep 100
            }
            if (ok := selfFindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.12 * PicTolerance, 0.13 * PicTolerance, selfFindText().PicLib("红圈的右边缘黄边"), , 0, , , , , zoomW, zoomH)) {
                AddLog("检测到红圈的右边缘黄边")
                selfFindText().Click(X - 70 * zoomW, Y, 0)
                Sleep 100
                Click "down left"
                Sleep 700
                Click "up left"
                Sleep 100
            }
        }
        if EventStory {
            ; 跳过剧情
            Send "{]}"
            ; 区域变化的提示
            if (ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.445 * nikkePosW . " ", nikkePosY + 0.561 * nikkePosH . " ", nikkePosX + 0.445 * nikkePosW + 0.111 * nikkePosW . " ", nikkePosY + 0.561 * nikkePosH + 0.056 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("前往区域的图标"), , , , , , , zoomW, zoomH)) {
                selfFindText().Click(X, Y + 400 * zoomH, "L")
            }
        }
        ; 检测自动战斗和爆裂
        ;if g_settings["CheckAuto"] {
        ;    CheckAuto
        ;}
        ;无限之塔的位置
        if (ok := selfFindText(&X, &Y, nikkePosX + 0.855 * nikkePosW . " ", nikkePosY + 0.907 * nikkePosH . " ", nikkePosX + 0.855 * nikkePosW + 0.031 * nikkePosW . " ", nikkePosY + 0.907 * nikkePosH + 0.081 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("TAB的图标"), , 0, , , , , zoomW, zoomH)) {
            AddLog("[无限之塔胜利]TAB已命中")
            break
        }
        ; 无限之塔失败的位置
        else if (ok := selfFindText(&X, &Y, nikkePosX + 0.784 * nikkePosW . " ", nikkePosY + 0.895 * nikkePosH . " ", nikkePosX + 0.784 * nikkePosW + 0.031 * nikkePosW . " ", nikkePosY + 0.895 * nikkePosH + 0.078 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("TAB的图标"), , 0, , , , , zoomW, zoomH)) {
            AddLog("[无限之塔失败]TAB已命中")
            break
        }
        ; 新人竞技场+模拟室+异常拦截的位置
        else if (ok := selfFindText(&X, &Y, nikkePosX + 0.954 * nikkePosW . " ", nikkePosY + 0.913 * nikkePosH . " ", nikkePosX + 0.954 * nikkePosW + 0.043 * nikkePosW . " ", nikkePosY + 0.913 * nikkePosH + 0.080 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("TAB的图标"), , 0, , , , , zoomW, zoomH)) {
            AddLog("[新人竞技场|模拟室|异常拦截|推图]TAB已命中")
            break
        }
        else if (ok := selfFindText(&X, &Y, nikkePosX + 0.012 * nikkePosW . " ", nikkePosY + 0.921 * nikkePosH . " ", nikkePosX + 0.012 * zoomW + (0.036 + 0.004 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.921 * nikkePosH + 0.072 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("重播的图标"), , 0, , , , , zoomW, zoomH)) {
            AddLog("[竞技场快速战斗失败]重播的图标已命中", "MAROON")
            break
        }
        else if (ok := selfFindText(&X, &Y, nikkePosX + 0.484 * nikkePosW . " ", nikkePosY + 0.877 * nikkePosH . " ", nikkePosX + 0.484 * nikkePosW + 0.032 * nikkePosW . " ", nikkePosY + 0.877 * nikkePosH + 0.035 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("ESC"), , 0, , , , , zoomW, zoomH)) {
            AddLog("[扫荡|活动推关]ESC已命中")
            break
        }
        ; 基地防御等级提升的页面
        if (ok := selfFindText(&X, &Y, nikkePosX + 0.490 * nikkePosW . " ", nikkePosY + 0.426 * nikkePosH . " ", nikkePosX + 0.490 * nikkePosW + 0.016 * nikkePosW . " ", nikkePosY + 0.426 * nikkePosH + 0.029 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("蓝色的右箭头"), , , , , , , zoomW, zoomH)) {
            idleClick
        }
        ;间隔500ms
        Sleep 500
    }
    ;是否需要截图
    if Screenshot {
        Sleep 1000
        TimeString := FormatTime(, "yyyyMMdd_HHmmss")
        selfFindText().SavePic(A_ScriptDir "\Screenshot\" TimeString ".jpg", nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, ScreenShot := 1)
    }
    ;有灰色的锁代表赢了但次数耗尽
    if (ok := selfFindText(&X, &Y, nikkePosX + 0.893 * nikkePosW . " ", nikkePosY + 0.920 * nikkePosH . " ", nikkePosX + 0.893 * nikkePosW + 0.019 * nikkePosW . " ", nikkePosY + 0.920 * nikkePosH + 0.039 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("灰色的锁"), , , , , , , zoomW, zoomH)) {
        currentVictory := currentVictory + 1
        if currentVictory > 1 {
            AddLog("共胜利" currentVictory "次")
        }
    }
    ;有编队代表输了，点Esc
    if (ok := selfFindText(&X, &Y, nikkePosX, nikkePosY, nikkePosX + nikkePosW, nikkePosY + nikkePosH, 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("编队的图标"), , 0, , , , , zoomW, zoomH)) {
        AddLog("战斗失败！尝试返回", "MAROON")
        back
        Sleep 1000
        LastVictoryCount := currentVictory ; 更新全局变量
        return False
    }
    ;如果有下一关，就点下一关（爬塔的情况）
    else if (ok := selfFindText(&X, &Y, nikkePosX + 0.889 * nikkePosW . " ", nikkePosY + 0.912 * nikkePosH . " ", nikkePosX + 0.889 * nikkePosW + 0.103 * nikkePosW . " ", nikkePosY + 0.912 * nikkePosH + 0.081 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("白色的下一关卡"), , , , , , , zoomW, zoomH)) {
        AddLog("战斗成功！尝试进入下一关", "GREEN")
        currentVictory := currentVictory + 1
        if currentVictory > 1 {
            AddLog("共胜利" currentVictory "次")
        }
        selfFindText().Click(X, Y + 20 * zoomH, "L")
        Sleep 5000
        if EventStory {
            BattleSettlement(currentVictory, "EventStory")
        }
        else {
            BattleSettlement(currentVictory)
        }
    }
    ;有灰色的下一关卡代表赢了但次数耗尽
    else if (ok := selfFindText(&X, &Y, nikkePosX + 0.889 * nikkePosW . " ", nikkePosY + 0.912 * nikkePosH . " ", nikkePosX + 0.889 * nikkePosW + 0.103 * nikkePosW . " ", nikkePosY + 0.912 * nikkePosH + 0.081 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("灰色的下一关卡"), , , , , , , zoomW, zoomH)) {
        AddLog("战斗结束！")
        currentVictory := currentVictory + 1
        if currentVictory > 1 {
            AddLog("共胜利" currentVictory "次")
        }
        back
        Sleep 1000
        Send "{]}"
        LastVictoryCount := currentVictory
        return True
    }
    ;没有编队也没有下一关就点Esc（普通情况或者爬塔次数用完了）
    else {
        AddLog("战斗结束！")
        back
        Sleep 1000
        Send "{]}"
        LastVictoryCount := currentVictory
        return True
    }
}

createOutline(x1,y1,x2,y2){
    rect := DrawRectangle(Integer(x1),Integer(y1),Integer(x2),Integer(y2), 0xff0000, 0.5)
    MsgBox("Click ok to destroy rectangle")
    rect.Destroy()
}

;tag 颜色判断
IsSimilarColor(targetColor, color) {
    tr := Format("{:d}", "0x" . substr(targetColor, 3, 2))
    tg := Format("{:d}", "0x" . substr(targetColor, 5, 2))
    tb := Format("{:d}", "0x" . substr(targetColor, 7, 2))
    pr := Format("{:d}", "0x" . substr(color, 3, 2))
    pg := Format("{:d}", "0x" . substr(color, 5, 2))
    pb := Format("{:d}", "0x" . substr(color, 7, 2))
    distance := sqrt((tr - pr) ** 2 + (tg - pg) ** 2 + (tb - pb) ** 2)
    if (distance < 15)
        return true
    return false
}
;tag 颜色
UserCheckColor(sX, sY, sC, k) {
    loop sX.Length {
        uX := Round(sX[A_Index] * k)
        uY := Round(sY[A_Index] * k)
        uC := PixelGetColor(uX, uY)
        if (!IsSimilarColor(uC, sC[A_Index]))
            return 0
    }
    return 1
}

Recruit() {
    AddLog("结算招募")
    while !(ok := FindText(&X := "wait", &Y := 1, nikkePosX + 0.944 * nikkePosW . " ", nikkePosY + 0.011 * nikkePosH . " ", nikkePosX + 0.944 * nikkePosW + 0.015 * nikkePosW . " ", nikkePosY + 0.011 * nikkePosH + 0.029 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("招募·SKIP的图标"), , 0, , , , , zoomW, zoomH)) { ;如果没找到SKIP就一直点左下角（加速动画）
        idleClick
    }
    FindText().Click(X, Y, "L") ;找到了就点
    Sleep 3000
    while (ok := FindText(&X, &Y, nikkePosX + 0.421 * nikkePosW . " ", nikkePosY + 0.889 * nikkePosH . " ", nikkePosX + 0.421 * nikkePosW + 0.028 * nikkePosW . " ", nikkePosY + 0.889 * nikkePosH + 0.027 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, FindText().PicLib("确认"), , , , , , , zoomW, zoomH)) {
        FindText().Click(X, Y, "L")
        Sleep 3000
    }
}