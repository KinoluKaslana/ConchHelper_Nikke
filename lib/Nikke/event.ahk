#Requires AutoHotkey v2.0

#Include "..\baseFunc.ahk"
#Include "..\helper.ahk"

class event extends baseFunc{
    challengeAutoForm := false
    missionAutoForm := false
    static readSetting(){
        IniRead("eventSetting.ini", "eventEntry")
    }
    static smallEvent(thisObj){
            ;Text := "|<>F8A397-0.90$29.0000000003rU007z0CEDy0TUTw0z07s1y0Dk3y0TU7w0z07s1y0DnXy0Tb7xzz6Dzzy4Tzzw8zzzsFzTzkXy0TV7w0z2Ds1y4Tk3w0TU7s0/0Dk060TV0A0y3"
            ;selfFindText(&X, &Y, nikkePosX + 0.632 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH . " ", nikkePosX + 0.632 * nikkePosW + 0.140 * nikkePosW . " ", nikkePosY + 0.794 * nikkePosH + 0.108 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, Text, , , , , , , zoomW * 1.5, zoomH * 1.5) ? "111" : "222"

            ;selfFindText().Click(X,Y,"L")
    
            ;Send "{]}"
            ;Sleep 200
            ;idleClick
            ;Sleep 200
            ;Send "{]}"
            ;Sleep 200
            ;idleClick
            ;Sleep 2000

            btnChallenge := [970 / 2560, 990 / 1440, 1260 / 2560, 1070 / 1440]
            btnMission := []
            btnEnter := []

            if(selfFindText(&X,&Y, nikkePosX + btnChallenge[1] * nikkePosW . " ", nikkePosY + btnChallenge[2] * nikkePosH . " ", nikkePosX + btnChallenge[3] * nikkePosW . " ", nikkePosY + btnChallenge[4]  * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红点"), , , , , , , zoomW, zoomH)){
                AddLog("进入挑战关卡")
                clickBtn(btnChallenge *)
                Sleep 2000
                if(ok1 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("红色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                    AddLog("发现挑战关卡")
                    selfFindText().Click(X, Y, "L")
                    Sleep 2000
                    eventFormation(thisObj.challengeAutoForm ? 1 : 2)
                }
                if(ok2 := selfFindText(&X,&Y, nikkePosX + 0.359 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH . " ", nikkePosX + 0.359 * nikkePosW + 0.044 * nikkePosW . " ", nikkePosY + 0.347 * nikkePosH + 0.546 * nikkePosH . " ", 0.3 * PicTolerance, 0.3 * PicTolerance, FindText().PicLib("黄色的关卡的循环图标"), , , , , , , zoomW, zoomH)){
                    AddLog("发现重复挑战关卡")
                    selfFindText().Click(X, Y, "L")
                    Sleep 2000
                }
                if(ok1 || ok2){
                    enterBattle()
                    battleSettlement()
                    return
                }
                AddLog("未找到挑战开放关卡")
            }
            else{
                AddLog("挑战关卡无事件（红点）")
            }
            
    }

    init(mainGui, optStr){
        
    }
}