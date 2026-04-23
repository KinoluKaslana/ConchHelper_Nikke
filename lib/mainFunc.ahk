#Requires AutoHotkey v2.0

#Include <helper>
#Include <baseFunc>
#Include <Nikke\shop>
#Include <Nikke\simulation>
#Include <Nikke\arena>
#Include <Nikke\tower>
#Include <Nikke\award>
#Include <Nikke\event>

class mainFunc extends baseFunc{
    subFuncMap := Map()
    subSettingBtnArray := Array()
    subFuncObjArray := Array()
    curShow :=""

    smallEventObj := 0


    showSubFunc(funcDescribe){
        if(this.curShow != ""){
            this.curShow.hide()
        }
        this.subFuncMap[funcDescribe].show()
        this.curShow := this.subFuncMap[funcDescribe]
    }

    addCheckRow(mainGui, mainGuiWidth, funcObj, funcDescribe, optStr){
        super.addCheckRow(this, mainGui, funcDescribe, optStr, ObjBindMethod(funcObj, "action"))

        settingBtn := mainGui.Add("Button", "HP W30 YP XM+" . (mainGuiWidth - 30), "⚙")
        settingBtn.OnEvent("Click", (settingBtn, eventInfo) => this.showSubFunc(funcDescribe))
        this.subSettingBtnArray.push(settingBtn)

        this.subFuncMap[funcDescribe] := funcObj
    }
    
    static mainFuncActionEnd(thisObj){
        global shopFreshFail
        if(thisObj.jobNum){
            AddLog("所有任务执行完毕！")
            if(shopFreshFail){
                AddLog("商店可能刷新失败！！", "Red")
            }
            else{
                shopFreshFail := true
            }
        }
        else{
            AddLog("未勾选任何主任务")
        }
    }

    static mainFuncActionBegin(){
        AddLog("DORO!!!!!")
        backHall()
        ;loop 4 {
        ;    idleClick()
        ;    Sleep 500
        ;}
    }

    static toggleCurFunc(thisObj){
        if(thisObj.curShow == ""){
            return
        }
        thisObj.curShow.toggleAll()
    }

    static toggleAll(thisObj){
        thisObj.toggleAll()
        for subFuncObj in thisObj.subFuncObjArray {
            subFuncObj.toggleAll()
        }
    }

    init(mainGui, mainGuiWidth, optStr){
        shopObj := shop().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(shopObj)
        simulationObj := simulation().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(simulationObj)
        arenajObj := arena().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(arenajObj)
        towerObj := tower().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(towerObj)
        awardObj := award().regFunc(mainGui, "X280 Y35 W180 R1.2")
        this.subFuncObjArray.Push(awardObj)
        this.smallEventObj := event().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(this.smallEventObj)
        
        this.addCheckRow(mainGui, mainGuiWidth, shopObj, "商店", optStr)
        this.addCheckRow(mainGui, mainGuiWidth, simulationObj, "模拟室", "XS+5 YS+50 H30 W150")
        this.addCheckRow(mainGui, mainGuiWidth, arenajObj, "竞技场", "XS+5 YS+80 H30 W150")
        this.addCheckRow(mainGui, mainGuiWidth, towerObj, "爬塔", "XS+5 YS+110 H30 W150")
        this.addCheckRow(mainGui, mainGuiWidth, awardObj, "常规奖励", "XS+5 YS+140 H30 W150")
        this.addCheckRow(mainGui, mainGuiWidth, this.smallEventObj, "小活动", "XS+5 YS+170 H30 W150")

        this.onBegin := mainFunc.mainFuncActionBegin

        this.forceCallEnd := true
        this.onEnd := mainFunc.mainFuncActionEnd.Bind(this)

        mainFuncToggle := mainGui.Add("Button", "XS+205 YS+2 W20 H20", "✅")
        mainFuncToggle.OnEvent("Click", (settingBtn, eventInfo) => mainFunc.toggleAll(this))
        subFuncToggle := mainGui.Add("Button", "XS+228 YS+2 W20 H20", "✔")
        subFuncToggle.OnEvent("Click", (settingBtn, eventInfo) => mainFunc.toggleCurFunc(this))
    }

    getObj(describe){
        if (this.subFuncMap[describe]) {
            return this.subFuncMap[describe]
        }
    }

    regFunc(mainGui, mainGuiWidth, optStr){
        this.init(mainGui, mainGuiWidth, optStr)
        return this
    }
}