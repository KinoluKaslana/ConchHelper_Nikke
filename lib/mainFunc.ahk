#Requires AutoHotkey v2.0

#Include <baseFunc>
#Include <Nikke\shop>
#Include <Nikke\award>

class mainFunc extends baseFunc{
    subFuncMap := Map()
    subFuncObjArray := Array()
    curShow :=""

    showSubFunc(funcDescribe){
        if(this.curShow != ""){
            this.curShow.hide()
        }
        this.subFuncMap[funcDescribe].show()
        this.curShow := this.subFuncMap[funcDescribe]
    }

    addCheckRow(mainGui, mainGuiWidth, funcObj, funcDescribe, optStr){
        MsgBox funcObj.__Class "    Func Name   " funcObj.action.Name
        ;checkbox := super.addCheckRow(mainGui, funcDescribe, optStr, funcObj.action)

        this.jobSet.addJob(funcDescribe, funcObj.action)
        checkboxObj := mainGui.Add("CheckBox", optStr, funcDescribe)
        checkboxObj.OnEvent("Click", (checkboxObj, eventInfo) => this.toggleStatus(funcDescribe))
        this.guiObj.push(checkboxObj)

        settingBtn := mainGui.Add("Button", "HP W30 YP XM+" . (mainGuiWidth - 30), "⚙")
        settingBtn.OnEvent("Click", (settingBtn, eventInfo) => this.showSubFunc(funcDescribe))
        this.guiObj.push(settingBtn)

        this.subFuncMap[funcDescribe] := funcObj
    }

    init(mainGui, mainGuiWidth, optStr){
        shopObj := shop().regFunc(mainGui, "X280 Y35 W180 R1.2")
        this.subFuncObjArray.Push(shopObj)
        awardObj := award().regFunc(mainGui, "X280 Y35 W180 R1.2")
        this.subFuncObjArray.Push(awardObj)
        
        this.addCheckRow(mainGui, mainGuiWidth, shopObj, "商店", optStr)
        this.addCheckRow(mainGui, mainGuiWidth, awardObj, "奖励领取", "XS+5 YS+80 R1.2 W180")
    }

    regFunc(mainGui, mainGuiWidth, optStr){
        this.init(mainGui, mainGuiWidth, optStr)
        return this
    }
}