#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\helper.ahk"

class award extends baseFunc{
    static AwardOutpost() {
        AddLog("开始任务：前哨基地收菜", "Fuchsia")
        backHall()
        enterOutpost()
        while true {
            if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.884 * nikkePosW . " ", nikkePosY + 0.904 * nikkePosH . " ", nikkePosX + 0.884 * nikkePosW + 0.114 * nikkePosW . " ", nikkePosY + 0.904 * nikkePosH + 0.079 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("溢出资源的图标"), , , , , , , zoomW, zoomH)) {
                Sleep 1000
                AddLog("点击右下角资源")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
            }
            if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.527 * nikkePosW . " ", nikkePosY + 0.832 * nikkePosH . " ", nikkePosX + 0.527 * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.832 * nikkePosH + 0.041 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("获得奖励的图标"), , , , , , , zoomW, zoomH)) {
                break
            }
        }
        if (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.490 * nikkePosW . " ", nikkePosY + 0.820 * nikkePosH . " ", nikkePosX + 0.490 * nikkePosW + 0.010 * nikkePosW . " ", nikkePosY + 0.820 * nikkePosH + 0.017 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            while (ok := selfFindText(&X, &Y, nikkePosX + 0.490 * nikkePosW . " ", nikkePosY + 0.820 * nikkePosH . " ", nikkePosX + 0.490 * nikkePosW + 0.010 * nikkePosW . " ", nikkePosY + 0.820 * nikkePosH + 0.017 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                selfFindText().Click(X - 50 * zoomW, Y + 50 * zoomH, "L")
                AddLog("点击免费歼灭红点")
                Sleep 1000
            }
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.465 * nikkePosW . " ", nikkePosY + 0.738 * nikkePosH . " ", nikkePosX + 0.465 * nikkePosW + 0.163 * nikkePosW . " ", nikkePosY + 0.738 * nikkePosH + 0.056 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("进行歼灭的歼灭"), , , , , , , zoomW, zoomH)) {
                AddLog("点击进行免费一举歼灭")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
                while !(ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.503 * nikkePosW . " ", nikkePosY + 0.825 * nikkePosH . " ", nikkePosX + 0.503 * nikkePosW + 0.121 * nikkePosW . " ", nikkePosY + 0.825 * nikkePosH + 0.059 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("获得奖励的图标"), , , , , , , zoomW, zoomH)) {
                    idleClick
                    Sleep 1000
                }
            }
        }
        else AddLog("没有免费一举歼灭", "MAROON")
        AddLog("尝试常规收菜")
        if (ok := selfFindText(&X, &Y, nikkePosX + 0.503 * nikkePosW . " ", nikkePosY + 0.825 * nikkePosH . " ", nikkePosX + 0.503 * nikkePosW + 0.121 * nikkePosW . " ", nikkePosY + 0.825 * nikkePosH + 0.059 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("获得奖励的图标"), , , , , , , zoomW, zoomH)) {
            AddLog("点击收菜")
            selfFindText().Click(X, Y, "L")
            Sleep 1000
        }
        else AddLog("没有可收取的资源", "MAROON")
        AddLog("尝试返回前哨基地主页面")
        while !(ok := selfFindText(&X, &Y, nikkePosX + 0.884 * nikkePosW . " ", nikkePosY + 0.904 * nikkePosH . " ", nikkePosX + 0.884 * nikkePosW + 0.114 * nikkePosW . " ", nikkePosY + 0.904 * nikkePosH + 0.079 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("溢出资源的图标"), , , , , , , zoomW, zoomH)) {
            idleClick
            Sleep 500
        }
        AddLog("已返回前哨基地主页面")            
        award.AwardOutpostDispatch()
        backHall
    }
    ;tag 派遣
    static AwardOutpostDispatch() {
        AddLog("开始任务：派遣委托", "Fuchsia")
        AddLog("查找派遣公告栏")
        if (ok := selfFindText(&X := "wait", &Y := 5, nikkePosX + 0.500 * nikkePosW . " ", nikkePosY + 0.901 * nikkePosH . " ", nikkePosX + 0.500 * nikkePosW + 0.045 * nikkePosW . " ", nikkePosY + 0.901 * nikkePosH + 0.092 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("派遣公告栏的图标"), , , , , , , zoomW, zoomH)) {
            AddLog("点击派遣公告栏")
            selfFindText().Click(X, Y, "L")
            Sleep 1000
            while (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.547 * nikkePosW . " ", nikkePosY + 0.807 * nikkePosH . " ", nikkePosX + 0.547 * nikkePosW + 0.087 * nikkePosW . " ", nikkePosY + 0.807 * nikkePosH + 0.066 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("获得奖励的图标"), , , , , , , zoomW * 0.8, zoomH * 0.8)) {
                AddLog("点击全部领取")
                selfFindText().Click(X + 100 * zoomH, Y, "L")
                Sleep 500
            }
            else AddLog("没有可领取的奖励", "MAROON")
            while !(ok := selfFindText(&X, &Y, nikkePosX + 0.378 * nikkePosW . " ", nikkePosY + 0.137 * nikkePosH . " ", nikkePosX + 0.378 * nikkePosW + 0.085 * nikkePosW . " ", nikkePosY + 0.137 * nikkePosH + 0.040 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("派遣公告栏最左上角的派遣"), , , , , , , zoomW, zoomH)) {
                scaledClick(1595, 1806)
                Sleep 500
            }
            if (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.456 * nikkePosW . " ", nikkePosY + 0.807 * nikkePosH . " ", nikkePosX + 0.456 * nikkePosW + 0.087 * nikkePosW . " ", nikkePosY + 0.807 * nikkePosH + 0.064 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("蓝底白色右箭头"), , , , , , , zoomW, zoomH)) {
                AddLog("尝试全部派遣")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
            }
            else AddLog("没有可进行的派遣")
            if (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.501 * nikkePosW . " ", nikkePosY + 0.814 * nikkePosH . " ", nikkePosX + 0.501 * nikkePosW + 0.092 * nikkePosW . " ", nikkePosY + 0.814 * nikkePosH + 0.059 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("白底蓝色右箭头"), , , , , , , zoomW, zoomH)) {
                AddLog("点击全部派遣")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
            }
        }
        else AddLog("派遣公告栏未找到！")
    }
    ;endregion 前哨基地
    ;region 咨询
    ;tag 好感度咨询
    static AwardAdvise() {
        while !(ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.069 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("圈中的感叹号"), , , , , , , zoomW, zoomH)) {
            scaledClick(1493, 1949)
            AddLog("点击妮姬的图标，进入好感度咨询")
        }
        Sleep 2000
        while (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + (0.818 + 0.082 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.089 * nikkePosH . " ", nikkePosX + (0.818 + 0.082 * nikkeServer) * nikkePosW + 0.089 * nikkePosW . " ", nikkePosY + 0.089 * nikkePosH + 0.056 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("咨询的图标"), , , , , , , zoomW, zoomH)) {
            selfFindText().Click(X, Y, "L")
            Sleep 1000
            if A_Index > 10 {
                MsgBox("未找到好感度咨询图标")
                Pause
            }
        }
        AddLog("已进入好感度咨询界面")
        ; 花絮鉴赏会
        ;award.AwardAppreciation
        while (
            (!nikkeServer && ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.118 * nikkePosW . " ", nikkePosY + 0.356 * nikkePosH . " ", nikkePosX + 0.118 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.356 * nikkePosH + 0.022 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("》》》"), , , , , , , zoomW, zoomH)) ||
            (nikkeServer && ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.166 * nikkePosW . " ", nikkePosY + 0.376 * nikkePosH . " ", nikkePosX + 0.166 * nikkePosW + 0.025 * nikkePosW . " ", nikkePosY + 0.376 * nikkePosH + 0.01 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("CN_-."), , , , , , , zoomW * 1.5, zoomH * 1.5))) {
                if(nikkeServer)
                    selfFindText().Click(X, Y - 30 * zoomH, "L")
                else
                    selfFindText().Click(X + 50 * zoomW, Y, "L")
            AddLog("点击左上角的妮姬")
            Sleep 500
        }
        AddLog("开始任务：妮姬咨询", "Fuchsia")
        while true {
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.572 * nikkePosW . " ", nikkePosY + 0.835 * nikkePosH . " ", nikkePosX + 0.572 * nikkePosW + 0.008 * nikkePosW . " ", nikkePosY + 0.835 * nikkePosH + 0.013 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("灰色的咨询次数0"), , , , , , , zoomW, zoomH)) {
                AddLog("咨询次数已耗尽", "MAROON")
                break
            }
            if A_Index > 20 {
                AddLog("妮姬咨询任务已超过20次，结束任务", "MAROON")
                break
            }
            if (
                (!nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + (0.637 - 0.0017 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.672 * nikkePosH . " ", nikkePosX + (0.637 - 0.0017 * nikkeServer) * nikkePosW + (0.004 + 0.0002 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.672 * nikkePosH + (0.013 + 0.001 * nikkeServer) * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("红色的20进度"), , , , , , , zoomW, zoomH)) || 
                (nikkeServer && isMax := selfFindText(&X_Max, &Y_Max, nikkePosX + 0.541 * nikkePosW . " ", nikkePosY + 0.637 * nikkePosH . " ", nikkePosX + 0.541 * nikkePosW + 0.030 * nikkePosW . " ", nikkePosY + 0.637 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("咨询·MAX"), , , , , , , zoomW, zoomH))) {
                AddLog("图鉴已满")
                ; 检测是否 MAX
                if(!nikkeServer && isMax := selfFindText(&X_Max, &Y_Max, nikkePosX + 0.541 * nikkePosW . " ", nikkePosY + 0.637 * nikkePosH . " ", nikkePosX + 0.541 * nikkePosW + 0.030 * nikkePosW . " ", nikkePosY + 0.637 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("咨询·MAX"), , , , , , , zoomW, zoomH))
                {}
                ; 如果是 MAX 且 未开启强制执行，则跳过
                if (isMax) {
                    AddLog("好感度已满，跳过")
                }
                ; 如果 (不是 MAX) 或者 (是 MAX 但开启了强制执行)，则尝试快速咨询
                else if (ok := selfFindText(&X, &Y, nikkePosX + 0.501 * nikkePosW . " ", nikkePosY + 0.726 * nikkePosH . " ", nikkePosX + 0.501 * nikkePosW + 0.130 * nikkePosW . " ", nikkePosY + 0.726 * nikkePosH + 0.059 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("快速咨询的图标"), , , , , , , zoomW, zoomH)) {
                    AddLog(isMax ? "强制执行：尝试快速咨询" : "尝试快速咨询")
                    selfFindText().Click(X, Y, "L")
                    Sleep 1000
                    if (ok := selfFindText(&X, &Y, nikkePosX + 0.506 * nikkePosW . " ", nikkePosY + 0.600 * nikkePosH . " ", nikkePosX + 0.506 * nikkePosW + 0.125 * nikkePosW . " ", nikkePosY + 0.600 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
                        selfFindText().Click(X, Y, "L")
                        AddLog("已咨询" A_Index "次", "GREEN")
                        Sleep 1000
                    }
                }
                else AddLog("该妮姬已咨询")
                if ((nikkeServer && isMax && ok := selfFindText(&X, &Y, nikkePosX + 0.361 * nikkePosW . " ", nikkePosY + 0.512 * nikkePosH . " ", nikkePosX + 0.361 * nikkePosW + 0.026 * nikkePosW . " ", nikkePosY + 0.512 * nikkePosH + 0.046 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("红色的收藏图标"), , , , , , , zoomW, zoomH)) || (!nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + 0.361 * nikkePosW . " ", nikkePosY + 0.512 * nikkePosH . " ", nikkePosX + 0.361 * nikkePosW + 0.026 * nikkePosW . " ", nikkePosY + 0.512 * nikkePosH + 0.046 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("红色的收藏图标"), , , , , , , zoomW, zoomH))) {
                    selfFindText().Click(X, Y, "L")
                    AddLog("取消收藏该妮姬")
                }
            } else {
                AddLog("图鉴未满")
                if (ok := selfFindText(&X, &Y, nikkePosX + 0.502 * nikkePosW . " ", nikkePosY + 0.780 * nikkePosH . " ", nikkePosX + 0.502 * nikkePosW + 0.131 * nikkePosW . " ", nikkePosY + 0.780 * nikkePosH + 0.088 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("咨询的咨"), , , , , , , zoomW, zoomH)) {
                    AddLog("尝试普通咨询")
                    selfFindText().Click(X + 50 * zoomW, Y, "L")
                    Sleep 1000
                    if (ok := selfFindText(&X, &Y, nikkePosX + 0.506 * nikkePosW . " ", nikkePosY + 0.600 * nikkePosH . " ", nikkePosX + 0.506 * nikkePosW + 0.125 * nikkePosW . " ", nikkePosY + 0.600 * nikkePosH + 0.054 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("带圈白勾"), , , , , , , zoomW, zoomH)) {
                        selfFindText().Click(X, Y, "L")
                        Sleep 1000
                        AddLog("已咨询" A_Index "次")
                    }
                    Sleep 1000
                    while true {
                        AddLog("随机点击对话框")
                        scaledClick(1894, 1440) ;点击1号位默认位置
                        Sleep 200
                        scaledClick(1903, 1615) ;点击2号位默认位置
                        Sleep 200
                        Send "{]}" ;尝试跳过
                        Sleep 200
                        if A_Index > 5 and (ok := selfFindText(&X, &Y, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.069 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("圈中的感叹号"), , , , , , , zoomW, zoomH)) {
                            break
                        }
                    }
                    Sleep 1000
                }
                else {
                    AddLog("该妮姬已咨询")
                }
            }
            while !(ok := selfFindText(&X, &Y, nikkePosX + 0.003 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH . " ", nikkePosX + 0.003 * nikkePosW + 0.069 * nikkePosW . " ", nikkePosY + 0.009 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("圈中的感叹号"), , , , , , , zoomW, zoomH)) {
                AddLog("确认咨询结算")
                idleClick
            }
            ;award.AwardAdviseAward
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.970 * nikkePosW . " ", nikkePosY + 0.403 * nikkePosH . " ", nikkePosX + 0.970 * nikkePosW + 0.024 * nikkePosW . " ", nikkePosY + 0.403 * nikkePosH + 0.067 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("咨询·向右的图标"), , , , , , , zoomW, zoomH)) {
                AddLog("下一个妮姬")
                selfFindText().Click(X - 30 * zoomH, Y, "L")
                Sleep 1000
            }
        }
        backHall
    }
    ;tag 花絮鉴赏会
    static AwardAppreciation() {
        AddLog("开始任务：花絮鉴赏会", "Fuchsia")
        Sleep 1000
        while (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + (0.979 - 0.075 * nikkeServer) * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH . " ", nikkePosX + (0.979 - 0.075 * nikkeServer) * nikkePosW + 0.020 * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH + 0.034 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("红底的N图标"), , , , , , , zoomW, zoomH)) {
            selfFindText().Click(X - 50 * zoomH, Y + 50 * zoomH, "L")
            AddLog("点击花絮")
        }
        else {
            AddLog("未找到花絮鉴赏会的N图标", "MAROON")
            return
        }
        while (ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.363 * nikkePosW . " ", nikkePosY + 0.550 * nikkePosH . " ", nikkePosX + 0.363 * nikkePosW + 0.270 * nikkePosW . " ", nikkePosY + 0.550 * nikkePosH + 0.316 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("EPI"), , , , , , 1, zoomW, zoomH)) {
            AddLog("播放第一个片段")
            selfFindText().Click(X, Y, "L")
        }
        while true {
            if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.559 * nikkePosW . " ", nikkePosY + 0.893 * nikkePosH . " ", nikkePosX + 0.559 * nikkePosW + 0.070 * nikkePosW . " ", nikkePosY + 0.893 * nikkePosH + 0.062 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("领取"), , , , , , , zoomW, zoomH)) {
                AddLog("领取奖励")
                selfFindText().Click(X, Y, "L")
                sleep 500
                selfFindText().Click(X, Y, "L")
                sleep 500
                selfFindText().Click(X, Y, "L")
                sleep 500
                break
            }
            else {
                AddLog("播放下一个片段")
                Send "{]}" ;尝试跳过
                if (ok := selfFindText(&X, &Y, nikkePosX + 0.499 * nikkePosW . " ", nikkePosY + 0.513 * nikkePosH . " ", nikkePosX + 0.499 * nikkePosW + 0.140 * nikkePosW . " ", nikkePosY + 0.513 * nikkePosH + 0.072 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("播放"), , , , , , , zoomW, zoomH)) {
                    selfFindText().Click(X, Y, "L")
                }
            }
        }
        while !(ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.118 * nikkePosW . " ", nikkePosY + 0.356 * nikkePosH . " ", nikkePosX + 0.118 * nikkePosW + 0.021 * nikkePosW . " ", nikkePosY + 0.356 * nikkePosH + 0.022 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("》》》"), , , , , , , zoomW, zoomH)) {
            idleClick
        }
    }
    ;tag 自动观看新花絮并领取奖励
    static AwardAdviseAward() {
        if (ok := selfFindText(&X, &Y, nikkePosX + 0.643 * nikkePosW . " ", nikkePosY + 0.480 * nikkePosH . " ", nikkePosX + 0.643 * nikkePosW + 0.014 * nikkePosW . " ", nikkePosY + 0.480 * nikkePosH + 0.026 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , 1.2 * zoomW, 1.2 * zoomH)) {
            AddLog("点击红点")
            selfFindText().Click(X, Y, "L")
            Sleep 2000
            while (
                (!nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + 0.486 * nikkePosW . " ", nikkePosY + 0.131 * nikkePosH . " ", nikkePosX + 0.486 * nikkePosW + 0.015 * nikkePosW . " ", nikkePosY + 0.131 * nikkePosH + 0.025 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH) ||
                nikkeServer)) {
                if (ok := selfFindText(&X, &Y, nikkePosX + 0.617 * nikkePosW . " ", nikkePosY + 0.400 * nikkePosH . " ", nikkePosX + 0.617 * nikkePosW + 0.026 * nikkePosW . " ", nikkePosY + 0.400 * nikkePosH + 0.512 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("红点"), , , , , , 1, zoomW, zoomH)) {
                    AddLog("播放新的片段")
                    selfFindText().Click(X, Y, "L")
                    Sleep 3000
                    Send "{]}" ;尝试跳过
                    Sleep 3000
                    idleClick
                    Sleep 1000
                    back
                }
                scaledMove(1906, 1026)
                Send "{WheelDown 3}"
                Sleep 1000
            }
            if (!nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + 0.616 * nikkePosW . " ", nikkePosY + 0.132 * nikkePosH . " ", nikkePosX + 0.616 * nikkePosW + 0.014 * nikkePosW . " ", nikkePosY + 0.132 * nikkePosH + 0.024 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("红点"), , , , , , 1, zoomW, zoomH)) {
                selfFindText().Click(X, Y, "L")
                AddLog("点击咨询图鉴")
                Sleep 1000
                if (ok := selfFindText(&X, &Y, nikkePosX + 0.620 * nikkePosW . " ", nikkePosY + 0.829 * nikkePosH . " ", nikkePosX + 0.620 * nikkePosW + 0.016 * nikkePosW . " ", nikkePosY + 0.829 * nikkePosH + 0.026 * nikkePosH . " ", 0.25 * PicTolerance, 0.25 * PicTolerance, selfFindText().PicLib("红点"), , , , , , 1, zoomW, zoomH)) {
                    selfFindText().Click(X, Y, "L")
                    AddLog("点击领取奖励")
                    Sleep 1000
                }
            }
            loop 3 {
                idleClick
                Sleep 500
            }
        }
    }

    static AwardFriendPoint() {
        AddLog("开始任务：好友点数", "Fuchsia")
        while (ok := selfFindText(&X, &Y, nikkePosX + 0.957 * nikkePosW . " ", nikkePosY + 0.216 * nikkePosH . " ", nikkePosX + 0.957 * nikkePosW + 0.032 * nikkePosW . " ", nikkePosY + 0.216 * nikkePosH + 0.111 * nikkePosH . " ", 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("好友的图标"), , , , , , , zoomW, zoomH)) {
            AddLog("点击好友")
            selfFindText().Click(X, Y, "L")
            Sleep 4000
        }
        while (
            (!nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + 0.628 * nikkePosW . " ", nikkePosY + 0.822 * nikkePosH . " ", nikkePosX + 0.628 * nikkePosW + 0.010 * nikkePosW . " ", nikkePosY + 0.822 * nikkePosH + 0.017 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) || 
            (nikkeServer && ok := selfFindText(&X, &Y, nikkePosX + 0.563 * nikkePosW . " ", nikkePosY + 0.838 * nikkePosH . " ", nikkePosX + 0.563 * nikkePosW + 0.015 * nikkePosW . " ", nikkePosY + 0.838 * nikkePosH + 0.024 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("好友的爱心"), , , , , , , zoomW * 1.5, zoomH * 1.5))) {
            AddLog("点击赠送")
            selfFindText().Click(X - (50 * zoomW) * (!nikkeServer), Y + (50 * zoomH) * (!nikkeServer), "L")
            Sleep 3000
        }
        else {
            AddLog("好友点数已执行")
        }
        backHall
    }
    ;endregion 好友点数收取
    ;region 邮箱收取
    static AwardMail() {
        AddLog("开始任务：邮箱", "Fuchsia")
        while (ok := selfFindText(&X, &Y, nikkePosX + 0.962 * nikkePosW . " ", nikkePosY + 0.017 * nikkePosH . " ", nikkePosX + 0.962 * nikkePosW + 0.008 * nikkePosW . " ", nikkePosY + 0.017 * nikkePosH + 0.015 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            AddLog("点击邮箱")
            selfFindText().Click(X, Y, "L")
            Sleep 500
        }
        else {
            AddLog("邮箱已领取")
            return
        }
        while (ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.519 * nikkePosW . " ", nikkePosY + 0.817 * nikkePosH . " ", nikkePosX + 0.519 * nikkePosW + 0.110 * nikkePosW . " ", nikkePosY + 0.817 * nikkePosH + 0.063 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("白底蓝色右箭头"), , , , , , , zoomW, zoomH)) {
            AddLog("点击全部领取")
            selfFindText().Click(X + 50 * zoomH, Y, "L")
            Sleep 500
        }
        backHall
    }
    ;endregion 邮箱收取
    ;region 方舟排名奖励
    ;tag 排名奖励
    static AwardRanking() {
        AddLog("开始任务：方舟排名奖励", "Fuchsia")
        enterArk()
        if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.973 * nikkePosW . " ", nikkePosY + 0.134 * nikkePosH . " ", nikkePosX + 0.973 * nikkePosW + 0.020 * nikkePosW . " ", nikkePosY + 0.134 * nikkePosH + 0.083 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            selfFindText().Click(X - 30 * zoomW, Y + 30 * zoomH, "L")
        }
        else {
            AddLog("没有可领取的排名奖励，跳过")
            backHall
            return
        }
        if (ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.909 * nikkePosW . " ", nikkePosY + 0.915 * nikkePosH . " ", nikkePosX + 0.909 * nikkePosW + 0.084 * nikkePosW . " ", nikkePosY + 0.915 * nikkePosH + 0.056 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("获得奖励的图标"), , , , , , , zoomW * 0.8, zoomH * 0.8)) {
            Sleep 1000
            AddLog("点击全部领取")
            loop 3 {
                selfFindText().Click(X, Y - 20 * zoomH, "L")
                Sleep 500
            }
        }
        backHall
    }
    ;endregion 方舟排名奖励
    ;region 每日任务收取
    static AwardDaily() {
        AddLog("开始任务：每日任务收取", "Fuchsia")
        while (ok := selfFindText(&X, &Y, nikkePosX + 0.874 * nikkePosW . " ", nikkePosY + 0.073 * nikkePosH . " ", nikkePosX + 0.874 * nikkePosW + 0.011 * nikkePosW . " ", nikkePosY + 0.073 * nikkePosH + 0.019 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            selfFindText().Click(X, Y, "L")
            AddLog("点击每日任务图标")
            if (
                (!nikkeServer && ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.466 * nikkePosW . " ", nikkePosY + 0.093 * nikkePosH . " ", nikkePosX + 0.466 * nikkePosW + 0.068 * nikkePosW . " ", nikkePosY + 0.093 * nikkePosH + 0.035 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("每日任务·MISSION"), , , , , , , zoomW, zoomH))||
                (nikkeServer && ok := selfFindText(&X := "wait", &Y := 3, nikkePosX + 0.466 * nikkePosW . " ", nikkePosY + 0.093 * nikkePosH . " ", nikkePosX + 0.466 * nikkePosW + 0.068 * nikkePosW . " ", nikkePosY + 0.093 * nikkePosH + 0.035 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("每日任务·任务"), , , , , , , zoomW * 1.5, zoomH * 1.5))) {
                while !(ok := selfFindText(&X, &Y, nikkePosX + 0.548 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH . " ", nikkePosX + 0.548 * nikkePosW + 0.093 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH + 0.063 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("灰色的全部"), , , , , , , zoomW, zoomH)) {
                    scaledClick(2412, 1905)
                    AddLog("点击全部领取")
                    Sleep 2000
                }
                Sleep 1000
                backHall
            }
        }
        else {
            AddLog("每日任务奖励已领取")
            return
        }
    }
    ;endregion 每日任务收取
    ;region 通行证收取
    ;tag 通行证任务主逻辑
    static AwardPass() {
        AddLog("开始任务：通行证", "Fuchsia")
        t := 0
        Y_Offset := 0  ; 默认偏移量为 0
        ; 1. 检测节日特殊活动图标
        ; 如果检测到图标，说明 UI 发生了整体下移
        if (ok := selfFindText(&X, &Y, nikkePosX + 0.968 * nikkePosW, nikkePosY + 0.121 * nikkePosH, nikkePosX + 0.968 * nikkePosW + 0.030 * nikkePosW, nikkePosY + 0.121 * nikkePosH + 0.048 * nikkePosH, 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("节日特殊活动的图标"), , , , , , , zoomW, zoomH)) {
            AddLog("检测到节日特殊活动，启用坐标偏移模式", "MAROON")
            Y_Offset := 0.043  ; 根据预估值推算的纵坐标偏移比例
        }
        while true {
            ; --- 通行证 3+ 模式检测 ---
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.879 * nikkePosW, nikkePosY + (0.150 + Y_Offset) * nikkePosH, nikkePosX + 0.879 * nikkePosW + 0.019 * nikkePosW, nikkePosY + (0.150 + Y_Offset) * nikkePosH + 0.037 * nikkePosH, 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("通行证·3+"), , , , , , , zoomW, zoomH)) {
                AddLog("3+通行证模式")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
                ; 检查内部垂直排布的红点
                if (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.985 * nikkePosW, nikkePosY + (0.124 + Y_Offset) * nikkePosH, nikkePosX + 0.985 * nikkePosW + 0.015 * nikkePosW, nikkePosY + (0.124 + Y_Offset) * nikkePosH + 0.261 * nikkePosH, 0.2 * PicTolerance, 0.2 * PicTolerance, selfFindText().PicLib("红点"), , , , , , 3, zoomW, zoomH)) {
                    selfFindText().Click(X - 20 * zoomW, Y + 20 * zoomH, "L")
                    t += 1
                    AddLog("执行第" t "个通行证")
                    award.OneAwardPass
                    backHall()
                    continue
                }
            }
            ; --- 通行证 2 模式检测 ---
            else if (ok := selfFindText(&X, &Y, nikkePosX + 0.878 * nikkePosW, nikkePosY + (0.151 + Y_Offset) * nikkePosH, nikkePosX + 0.878 * nikkePosW + 0.021 * nikkePosW, nikkePosY + (0.151 + Y_Offset) * nikkePosH + 0.036 * nikkePosH, 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("通行证·2"), , , , , , , zoomW, zoomH)) {
                AddLog("2通行证模式")
                selfFindText().Click(X, Y, "L")
                Sleep 1000
            }
            else {
                AddLog("1通行证模式")
            }
            if t > 3 {
                AddLog("通行证任务异常跳出", "MAROON")
                break
            }
            ; --- 检查主界面通行证入口红点 ---
            if (ok := selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.983 * nikkePosW, nikkePosY + (0.131 + Y_Offset) * nikkePosH, nikkePosX + 0.983 * nikkePosW + 0.017 * nikkePosW, nikkePosY + (0.131 + Y_Offset) * nikkePosH + 0.029 * nikkePosH, 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
                selfFindText().Click(X - 50 * zoomW, Y + 50 * zoomH, "L")
                t += 1
                AddLog("执行第" t "个通行证")
                award.OneAwardPass
                backHall()
                continue
            }
            ; --- 检测是否有其他未完成的通行证图标红点 ---
            if (ok := selfFindText(&X, &Y, nikkePosX + 0.890 * nikkePosW, nikkePosY + (0.149 + Y_Offset) * nikkePosH, nikkePosX + 0.890 * nikkePosW + 0.010 * nikkePosW, nikkePosY + (0.149 + Y_Offset) * nikkePosH + 0.016 * nikkePosH, 0.4 * PicTolerance, 0.4 * PicTolerance, selfFindText().PicLib("红点"), , , , , , , zoomW * 0.8, zoomH * 0.8)) {
                selfFindText().Click(X, Y, "L")
            }
            else {
                AddLog("通行证已全部收取")
                break
            }
        }
        loop 3 {
            idleClick
        }
    }
    ;tag 执行一次通行证
    static OneAwardPass() {
        Sleep 3000
        loop 2 {
            if A_Index = 1 {
                scaledClick(2184, 670) ;点任务
                Sleep 1000
            }
            if A_Index = 2 {
                scaledClick(1642, 670) ;点奖励
                Sleep 1000
            }
            while !(ok := selfFindText(&X, &Y, nikkePosX + 0.429 * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH . " ", nikkePosX + 0.429 * nikkePosW + 0.143 * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("灰色的全部"), , , , , , , zoomW, zoomH)) and !(ok := selfFindText(&X, &Y, nikkePosX + 0.429 * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH . " ", nikkePosX + 0.429 * nikkePosW + 0.143 * nikkePosW . " ", nikkePosY + 0.903 * nikkePosH + 0.050 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("SP灰色的全部"), , , , , , , zoomW, zoomH)) {
                loop 3 {
                    scaledClick(2168, 2020) ;点领取
                    Sleep 500
                }
            }
        }
        back()
    }
    ;endregion 通行证收取
    ;region 每日免费招募
    static AwardFreeRecruit() {
        AddLog("开始任务：每日免费招募", "Fuchsia")
        if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.585 * nikkePosW . " ", nikkePosY + 0.922 * nikkePosH . " ", nikkePosX + 0.585 * nikkePosW + 0.051 * nikkePosW . " ", nikkePosY + 0.922 * nikkePosH + 0.036 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("白色的每天免费"), , , , , , , zoomW, zoomH)) {
            selfFindText().Click(X, Y, "L")
            AddLog("进入招募页面")
            Sleep 1000
            while (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.585 * nikkePosW . " ", nikkePosY + 0.922 * nikkePosH . " ", nikkePosX + 0.585 * nikkePosW + 0.051 * nikkePosW . " ", nikkePosY + 0.922 * nikkePosH + 0.036 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("白色的每天免费"), , , , , , , zoomW, zoomH)) {
                if (ok := selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.379 * nikkePosW . " ", nikkePosY + 0.761 * nikkePosH . " ", nikkePosX + 0.379 * nikkePosW + 0.047 * nikkePosW . " ", nikkePosY + 0.761 * nikkePosH + 0.035 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, selfFindText().PicLib("不获得"), , , , , , , zoomW, zoomH)) {
                    AddLog("进行招募")
                    Sleep 1000
                    selfFindText().Click(X, Y + 50 * zoomH, "L")
                    Sleep 1000
                    Recruit()
                }
                else {
                    ;点击翻页
                    Sleep 1000
                    scaledClick(3774, 1147)
                    Sleep 1000
                }
            }
        }
        else {
            AddLog("没有免费每日招募", "MAROON")
        }
        backHall
    }
    init(mainGui, optStr) {
        this.addCheckRow(mainGui, "前哨基地防御奖励领取", optStr, award.AwardOutpost)
        this.addCheckRow(mainGui,"咨询Nikke","",award.AwardAdvise)
        this.addCheckRow(mainGui,"好友点数收发","",award.AwardFriendPoint)
        this.addCheckRow(mainGui,"邮箱收取","",award.AwardMail)
        this.addCheckRow(mainGui,"方舟排名奖励","",award.AwardRanking)
        this.addCheckRow(mainGui,"任务收取","",award.AwardDaily)
        this.addCheckRow(mainGui,"通行证收取","",award.AwardPass)
    }
}