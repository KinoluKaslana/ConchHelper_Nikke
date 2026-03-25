#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\helper.ahk"

class event extends baseFunc{
    challengeAutoForm := false
    missionAutoForm := false
    eventNum := 0

    challengeBtnSet := Array()
    missionBtnSet := Array()
    enterBtnSet := Array()
    hardBtnSet := Array()

    enrtyTextSet := Array()
    storyRangeSet := Array()

    ;正常模式下，1是开放关卡，0是未解锁，-1是不可重复, 2是重复战斗
    static checkLoop(range, hardBtn := false){
        clickBtn(false, range *)
        Sleep 300
        scaledMove(420, 560)
        loop 3 {
            if(hardBtn){
                break
            }
            Sleep 700
            ;AddLog("点击关卡选项")
            if(ok := selfFindText(&X, &Y, nikkePosX + 0.357 * nikkePosW . " ", nikkePosY + 0.667 * nikkePosH . " ", nikkePosX + 0.357 * nikkePosW + 0.02 * nikkePosW . " ", nikkePosY+ 0.667 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("CN_AIM"), , , , , , , zoomW, zoomH)){
                if(ok :=  selfFindText(&X := "wait", &Y := 1, nikkePosX + 0.506 * nikkePosW . " ", nikkePosY + 0.826 * nikkePosH . " ", nikkePosX + 0.506 * nikkePosW + 0.145 * nikkePosW . " ", nikkePosY + 0.826 * nikkePosH + 0.065 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("快速战斗的图标"), , , , , , , zoomW, zoomH)){
                    backSelectState()
                    return 2
                }
                backSelectState()
                return 1
            }
            Sleep 500
        }
        ok1 := 0
        ok2 := 0
        count := 0
        clickBtn(false, range *)
        Sleep 300
        scaledMove(420, 560)
        while true {
            if(count == 5 && hardBtn){
                clickBtn(false, range *)
                Sleep 300
                scaledMove(420, 560)
                if(hardBtn){
                    break
                }
            }
            if(ok1 := selfFindText(&X,&Y, nikkePosX + 0.474 * nikkePosW . " ", nikkePosY + 0.458 * nikkePosH . " ", nikkePosX + 0.525 * nikkePosW . " ", nikkePosY + 0.496  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("解锁条件"), , , , , , , zoomW, zoomH) || ok2 := selfFindText(&X,&Y, nikkePosX + 0.473 * nikkePosW . " ", nikkePosY + 0.492 * nikkePosH . " ", nikkePosX + 0.492 * nikkePosW . " ", nikkePosY + 0.510  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("重复通关"), , , , , , , zoomW, zoomH)){
                break
            }
            Sleep 200
            count++
        }
        if(ok1 && ok1[1].id == "解锁条件"){
            return 0
        }
        if(ok2 && ok2[1].id == "重复通关"){
            return -1
        }
        if(hardBtn){
            return 1
        }
    }
    
    static readSetting(thisObj){
        eventNum := thisObj.eventNum := Integer(IniRead(A_ScriptDir "\\eventSetting.ini", "event", "smallEventNum"))
        _section := (eventNum, valueName, isString:=false) => event.getSetting.Bind(thisObj, "smallEventSetting_" eventNum)(valueName, isString)

        if(thisObj.eventNum){
            AddLog("读取配置文件，发现" thisObj.eventNum "个小活动的配置")
        }
        if(!thisObj.eventNum){
            AddLog("未开启或未配置小活动")
            return
        }
        while (A_Index <= thisObj.eventNum){
            AddLog("读取小活动" A_IndeX "配置信息")
            section := (valueName, isString:=false) => _section(A_IndeX, valueName, isString)
            eventPosScale := section("Scale") == 4 ? 1 : 1.5
            thisObj.enrtYTeXtSet.push(section("TeXt", true))
            thisObj.challengeBtnSet.push([section("cX1") / 3840 * eventPosScale, section("cY1") / 2160  * eventPosScale, section("cX2") / 3840 * eventPosScale, section("cY2") / 2160  *eventPosScale])
            thisObj.missionBtnSet.push([section("mX1") / 3840 * eventPosScale, section("mY1") / 2160  * eventPosScale, section("mX2") / 3840 * eventPosScale, section("mY2") / 2160  *eventPosScale])
            thisObj.enterBtnSet.push([section("eX1") / 3840 * eventPosScale, section("eY1") / 2160  * eventPosScale, section("eX2") / 3840 * eventPosScale, section("eY2") / 2160  *eventPosScale])
            thisObj.storYRangeSet.push([[section("range1_6X1") / 3840 * eventPosScale, section("range1_6Y1") / 2160 * eventPosScale, section("range1_6X2") / 3840 * eventPosScale, section("range1_6Y2") / 2160 * eventPosScale],
                [section("range6_EX1") / 3840 * eventPosScale, section("range6_EY1") / 2160 * eventPosScale, section("range6_EX2") / 3840 * eventPosScale, section("range6_EY2") / 2160 * eventPosScale]])
            thisObj.hardBtnSet.push([section("hardX1") / 3840 * eventPosScale, section("hardY1") / 2160  * eventPosScale, section("hardX2") / 3840 * eventPosScale, section("hardY2") / 2160  * eventPosScale])
        }
    }

    static begin(thisObj){
        event.readSetting(thisObj)
    }

    static getSetting(sectionName, valueName, isString := false){
        returnValue := IniRead(A_ScriptDir "\\eventSetting.ini", sectionName, valueName)
        if(!StrLen(returnValue) && !isString){
            return 0
        }
        return isString ? returnValue : Integer(returnValue)
    }

    static smallEventEntry(thisObj){
        eventIndex := 1
        backHall()
        while(true){
            if(eventIndex > thisObj.eventNum){
                AddLog("所有小活动执行完毕")
                break
            }
            if(ok := selfFindText(&X, &Y, nikkePosX + 0.632 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH . " ", nikkePosX + 0.632 * nikkePosW + 0.140 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH +0.108 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, thisObj.enrtyTextSet[eventIndex], , , , , , , zoomW * 1.5, zoomH * 1.5)){
                AddLog("找到小活动" eventIndex "图标，进入")
                selfFindText().Click(X,Y,"L")
                Send "{]}"
                Sleep 200
                idleClick
                Sleep 200
                Send "{]}"
                Sleep 200
                idleClick
                Sleep 2000

                AddLog("开始打小活动挑战关")
                challengeRet := event.smallEventChallenge(thisObj, eventIndex)
                if(challengeRet == 2){
                    AddLog("小活动挑战关完成，返回活动页面")
                    Sleep 2000
                    scaledMove(147,2047,3)
                    Sleep 500
                    scaledClick(147,2047)
                }
                else if(challengeRet == 0) {
                    AddLog("挑战关卡未完成(失败)", "red")
                    Sleep 2000
                    scaledMove(147,2047,3)
                    Sleep 500
                    scaledClick(147,2047)
                }
                
                AddLog("开始小活动推图")
                switch(event.smallEventStory(thisObj, eventIndex)){
                    case 0:
                    {
                        AddLog("小活动推图未完成", "red")
                        Sleep 2000
                        scaledMove(147,2047,3)
                        Sleep 500
                        scaledClick(147,2047)
                    }
                    case 1:
                    {
                        AddLog("推图完成，返回活动页面")
                        Sleep 2000
                        scaledMove(147,2047,3)
                        Sleep 500
                        scaledClick(147,2047)
                    }
                    case 2:
                    {
                        AddLog("推图关卡完成")
                    }
                }

                event.smallMission(thisObj, eventIndex)
                if((eventIndex + 1) <= thisObj.eventNum){
                    AddLog("尝试进入下一个小活动")
                }
                eventIndex++
                backHall()
            }
            else{
                AddLog("查找小活动" eventIndex "失败")
                if(thisObj.eventNum > 1){
                    AddLog("尝试点击切换按钮")
                    if(ok := selfFindText(&X, &Y, nikkePosX + 0.751 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH . " ", nikkePosX + 0.751 * nikkePosW + 0.022 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH + 0.037 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("活动·切换的图标"), , , , , , , zoomW, zoomH)) {
                        AddLog("切换活动")
                        selfFindText().Click(X, Y, "L")
                        Sleep 3000
                    }
                }
            }
        }
    }

    static smallEventChallenge(thisObj, index){
        global LastVictoryCount
        btnChallenge := thisObj.challengeBtnSet[index]
        thisObj.challengeAutoForm := thisObj.getCheckStatus("挑战自动编队")

        if(selfFindText(&X,&Y, nikkePosX + btnChallenge[1] * nikkePosW . " ", nikkePosY + btnChallenge[2] * nikkePosH . " ", nikkePosX + btnChallenge[3] * nikkePosW . " ", nikkePosY +btnChallenge[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)){
            AddLog("进入挑战关卡")
            clickBtn(false, btnChallenge *)
            Sleep 6000
            ok1 := 0
            ok2 := 0
            if(ok1 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 *nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                AddLog("发现挑战关卡")
                selfFindText().Click(X, Y, "L")
                Sleep 2000
                eventFormation(thisObj.challengeAutoForm ? 1 : 2)
            }
            else if(ok2 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 *nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("黄色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                AddLog("发现" ok2.Length "个可扫荡挑战关")
                Sleep 2000
            }
            if(ok1){
                enterBattle()
                battleSettlement(0, "Challenge")
                return 2
            }
            if(ok2){                
                maxY := -150000
                x := 0, y:=0
                loop ok2.Length {
                    if(ok2[A_Index].y > maxY){
                        x:=ok2[A_Index].x
                        y:=ok2[A_Index].y
                        maxY := y
                    }
                }
                selfFindText().Click(x,y,"L")
                Sleep 1000
                enterBattle()
                battleSettlement(0, "Challenge")
                return 2
            }
            AddLog("未找到挑战开放关卡")
        }
        else{
            AddLog("挑战关卡无事件（红点）")
            return 1
        }
        return 0 
    }

    static eventStoryCheck(checkRange, base := 0){
        storyStatus := [0,0,0,0,0,0]
        
        loop 6{
            logText := "第" A_Index + base "关"
            if((storyStatus[A_Index] := event.checkLoop(getSubRange(1, 6, 1, A_Index, checkRange *))) == 0){
                AddLog(logText . "未解锁")
                return storyStatus
            }
            else{
                logText := logText . (storyStatus[A_Index] == -1 ?  "已通关" : (storyStatus[A_Index] == 1 ? "可挑战" : "可重复挑战"))
            }
            AddLog(logText)
        }

        return storyStatus
    }

    static smallEventStory(thisObj, index){
        btnEnter := thisObj.enterBtnSet[index]
        thisObj.missionAutoForm := thisObj.getCheckStatus("推图自动编队")
        lastRepeatBtn := []

        if(selfFindText(&X,&Y, nikkePosX + btnEnter[1] * nikkePosW . " ", nikkePosY + btnEnter[2] * nikkePosH . " ", nikkePosX + btnEnter[3] * nikkePosW . " ", nikkePosY +btnEnter[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)){
            clickBtn(false, btnEnter *)
            While(!(ok := FindText(&X, &Y, nikkePosX + 0.004 * nikkePosW . " ", nikkePosY + 0.022 * nikkePosH . " ", nikkePosX + 0.004 * nikkePosW + 0.038 * nikkePosW . " ", nikkePosY + 0.022 * nikkePosH + 0.027 * nikkePosH . " ", 0.4 * PicTolerance, 0.4 * PicTolerance, FindText().PicLib("活动关卡"), , , , , , , zoomW, zoomH))){
                idleClick
                Sleep 300
                Send "{]}"
            }
            AddLog("进入活动推图关卡, 尝试进入困难关卡")
            if(event.checkLoop(thisObj.hardBtnSet[index], true)){
                clickBtn(false, thisObj.hardBtnSet[index] *)
                loop 3 {
                    idleClick
                    Sleep 300
                    Send "{]}"
                    Sleep 300
                }
                AddLog("进入活动困难关")
            }
            else{
                AddLog("困难关卡未开放")
            }
            Sleep 2000
            AddLog("正在检查关卡开放情况")
            AddLog("检查前6关开放情况")
            scaledMove(1920, 1080)
            storyStatusB := Array()
            loop 20{
                Click "WheelUp"
            }
            storyStatusA := event.eventStoryCheck(thisObj.storyRangeSet[index][1])
            if(storyStatusA[6] != 0){
                scaledMove(1920, 1080)
                loop 20{
                    Click "WheelDown"
                }
                storyStatusB := event.eventStoryCheck(thisObj.storyRangeSet[index][2], 6)
            }

            lastStage := -1
            lastRrtry := -1

            loop 6{
                ;第7关未开放
                if(storyStatusB.Length && !storyStatusB[1]){
                    lastRrtry := 4
                    lastStage := 6
                    break
                }
                switch(storyStatusA[A_Index]){
                    case 1:
                        if(lastRrtry < A_Index)
                            lastStage := A_Index
                    case 2:
                        if(lastStage < A_Index)
                            lastRrtry := A_Index
                    default: 
                }
                if(storyStatusB.Length)
                switch(storyStatusB[A_Index]){
                    case 1:
                        lastStage := A_Index + 6
                    case 2:
                        lastRrtry := A_Index + 6
                    default: 
                }
            }
            if(lastStage == -1){
                lastStage := 13
            }

            Sleep 2000
            scaledMove(1920, 1080)

            if(lastStage > 6 && lastStage <= 12){
                loop 20{
                    Click "WheelDown"
                }
            }
            else if(lastStage <= 6){
                loop 20{
                    Click "WheelUp"
                }
            }

            ;第12关已挑战，并且第11关状态可挑战
            if(lastStage > 12 && storyStatusB[5] == 2){
                clickBtn(false, getSubRange(1, 6, 1, 5, thisObj.storyRangeSet[index][2]*) *)
            } 
            else if(lastStage > 6 && lastStage <= 12){
                clickBtn(false, getSubRange(1, 6, 1, lastStage - 6, thisObj.storyRangeSet[index][2] *) *)
            }
            else if(lastStage <= 6) {
                clickBtn(false, getSubRange(1, 6, 1, lastStage, thisObj.storyRangeSet[index][1] *) *)
            }
            else {
                MsgBox "推图异常情况，手动复位后将继续扫描活动任务"
                return 1
            }
            eventFormation(thisObj.missionAutoForm ? 1 : 2)
            enterBattle()
            isFin := battleSettlement(0, "EventStory")
            if(LastVictoryCount >= 5 || isFin){
                return 1
            }
            
            ;特殊情况：当前lastStage + 胜利数大于12并且胜利数低于5,则扫荡第11关
            if(LastVictoryCount < 5 && (lastStage + LastVictoryCount > 12)){
                clickBtn(false, getSubRange(1, 6, 1, 5, thisObj.storyRangeSet[index][2]*) *)
                enterBattle()
                battleSettlement(0, "EventStory")
            }
            else{
                AddLog("推图失败", "Red")
                return 0
            }
            return 1
        }
        return 2
    }

    static smallMission(thisObj, index){
        btnMission := thisObj.missionBtnSet[index]
        AddLog("开始任务：小活动·任务领取", "Fuchsia")
        if (selfFindText(&X,&Y, nikkePosX + btnMission[1] * nikkePosW . " ", nikkePosY + btnMission[2] * nikkePosH . " ", nikkePosX + btnMission[3] * nikkePosW . " ", nikkePosY + btnMission[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 1000
            AddLog("已进入任务界面")
            count := 0
            while (count <= 1 || selfFindText(&X := "wait", &Y := 2, nikkePosX + 0.550 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH . " ", nikkePosX + 0.550 * nikkePosW + 0.09 * nikkePosW . " ", nikkePosY + 0.864 * nikkePosH + 0.068 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 *   PicTolerance, FindText().PicLib("小活动·全部领取"), , , , , , , zoomW * 1.5, zoomH * 1.5)) {
                loop 3 {
                    FindText().Click(X + 50 * zoomW, Y, "L")
                    Sleep 1000
                    AddLog("点击全部领取")
                }
                count++
                idleClick()
            }
        }
        else {
            AddLog("没有可领取的任务")
        }
    }

    smallEvent(){
        ;backHall()
        event.smallEventEntry(this)
    }

    init(mainGui, optStr){
        this.onBegin := event.begin(this)

        this.addCheckRow(this, mainGui, "小活动一键通", optStr, this.smallEvent)
        this.addCheckRow(this, mainGui, "挑战自动编队", "", (*)=>{})
        this.addCheckRow(this, mainGui, "推图自动编队", "", (*)=>{})
    }
}