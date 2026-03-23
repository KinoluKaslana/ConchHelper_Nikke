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
        loop 3 {
            if(hardBtn){
                break
            }
            clickBtn(false, range *)
            Sleep 700
            ;AddLog("点击关卡选项")
            if(ok := selfFindText(&X, &Y, nikkePosX + 0.357 * nikkePosW . " ", nikkePosY + 0.667 * nikkePosH . " ", nikkePosX + 0.357 * nikkePosW + 0.02 * nikkePosW . " ", nikkePosY+ 0.667 * nikkePosH + 0.028 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("CN_AIM"), , , , , , , zoomW * 1.5, zoomH * 1.5)){
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
        while true {
            clickBtn(false, range *)
            Sleep 1000
            if(ok1 := selfFindText(&X,&Y, nikkePosX + 0.474 * nikkePosW . " ", nikkePosY + 0.458 * nikkePosH . " ", nikkePosX + 0.525 * nikkePosW . " ", nikkePosY + 0.496  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("解锁条件"), , , , , , , zoomW * 1.5, zoomH * 1.5) || ok2 := selfFindText(&X,&Y, nikkePosX + 0.5 * nikkePosW . " ", nikkePosY + 0.493 * nikkePosH . " ", nikkePosX + 0.519 * nikkePosW . " ", nikkePosY + 0.510  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("重复通关"), , , , , , , zoomW * 1.5, zoomH * 1.5)){
                break
            }
        }
        if(ok1[1].id == "解锁条件"){
            return 0
        }
        if(ok2[1].id == "重复通关"){
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
                if(event.smallEventChallenge(thisObj, eventIndex)){
                    AddLog("小活动挑战关完成，返回活动页面")
                    Sleep 2000
                    back()
                    Sleep 2000
                }
                else{
                    AddLog("挑战关卡未完成", "red")
                    back()
                }
                
                AddLog("开始小活动推图")
                if(event.smallEventStory(thisObj, eventIndex)){
                    AddLog("推图完成，返回活动页面")
                    Sleep 2000
                    back()
                    Sleep 2000
                }
                else{
                    AddLog("小活动推图未完成", "red")
                    back()
                }

                event.smallMission(thisObj, eventIndex)

                AddLog("尝试进入下一个小活动")
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
        btnChallenge := thisObj.challengeBtnSet[index]
        thisObj.challengeAutoForm := thisObj.getCheckStatus("挑战自动编队")

        if(selfFindText(&X,&Y, nikkePosX + btnChallenge[1] * nikkePosW . " ", nikkePosY + btnChallenge[2] * nikkePosH . " ", nikkePosX + btnChallenge[3] * nikkePosW . " ", nikkePosY +btnChallenge[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)){
            AddLog("进入挑战关卡")
            clickBtn(false, btnChallenge *)
            Sleep 6000
            if(ok1 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 *nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                AddLog("发现挑战关卡")
                selfFindText().Click(X, Y, "L")
                Sleep 2000
                eventFormation(thisObj.challengeAutoForm ? 1 : 2)
            }
            else if(ok2 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 *nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("黄色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                AddLog("发现重复挑战关卡")
                selfFindText().Click(X, Y, "L")
                Sleep 2000
            }
            if(ok1 || ok2){
                enterBattle()
                battleSettlement(0, "Challenge")
                return true
            }
            AddLog("未找到挑战开放关卡")
        }
        else{
            AddLog("挑战关卡无事件（红点）")
        }
        return false 
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
        thisObj.missionAutoForm := thisObj.getCheckStatus("挑战自动编队")
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
                loop 20{
                    Click "WheelDown"
                }
                storyStatusB := event.eventStoryCheck(thisObj.storyRangeSet[index][2], 6)
            }

            lastStage := -1
            ;第六关为通过或第六关通过但11关没有开启或通关
            if(!storyStatusA[6] || !(storyStatusB[5] == 2)){
                ;7-12关第7关未开放
                if(storyStatusB.Length == 6 && !storyStatusB[1]){
                    lastStage := 6
                }
                else if(storyStatusB.Length == 6 && storyStatusB[1]){
                    loop 6{
                        if(storyStatusB[-1 * A_Index]){
                            lastStage := 6 - A_Index + 7
                            break
                        }
                    }
                }
                if(lastStage < 0 && !storyStatusA[6]){
                    loop 6{
                        if(storyStatusA[-1 * A_Index]){
                            lastStage := 6 - A_Index + 1
                            break
                        }
                    }
                }
            }

            Sleep 2000
            scaledMove(1920, 1080)

            if(lastStage > 6){
                loop 20{
                    Click "WheelDown"
                }
            }
            else{
                loop 20{
                    Click "WheelUp"
                }
            }

            ;第6关已挑战，并且第11关状态可挑战
            if(lastStage == 12 && storyStatusB[5] == 2){
                clickBtn(false, getSubRange(1, 6, 1, 5, thisObj.storyRangeSet[index][2]*) *)
                eventFormation(thisObj.missionAutoForm ? 1 : 2)
                enterBattle()
                battleSettlement(0, "EventStory")
                return true
            }

            if(lastStage > 6){
                clickBtn(false, getSubRange(1, 6, 1, lastStage - 6, thisObj.storyRangeSet[index][2] *) *)
            }
            else{
                clickBtn(false, getSubRange(1, 6, 1, lastStage, thisObj.storyRangeSet[index][1] *) *)
            }
            eventFormation(thisObj.missionAutoForm ? 1 : 2)
            enterBattle()
            battleSettlement(0, "EventStory")
            return true
        }
    }

    static smallMission(thisObj, index){
        btnMission := thisObj.missionBtnSet[index]
        AddLog("开始任务：小活动·任务领取", "Fuchsia")
        if (selfFindText(&X,&Y, nikkePosX + btnMission[1] * nikkePosW . " ", nikkePosY + btnMission[2] * nikkePosH . " ", nikkePosX + btnMission[3] * nikkePosW . " ", nikkePosY + btnMission[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)) {
            FindText().Click(X, Y, "L")
            Sleep 1000
            AddLog("已进入任务界面")
            if (ok := FindText(&X := "wait", &Y := 2, nikkePosX + 0.515 * nikkePosW . " ", nikkePosY + 0.862 * nikkePosH . " ", nikkePosX + 0.515 * nikkePosW + 0.119 * nikkePosW . " ", nikkePosY + 0.862 * nikkePosH + 0.068 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 *   PicTolerance, FindText().PicLib("小活动·全部领取"), , , , , , , zoomW, zoomH)) {
                loop 3 {
                    FindText().Click(X + 50 * zoomW, Y, "L")
                    Sleep 1000
                    AddLog("点击全部领取")
                }
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
        this.addCheckRow(this, mainGui, "挑战自动编队", "", ()=>{})
        this.addCheckRow(this, mainGui, "推图自动编队", "", ()=>{})
    }
}