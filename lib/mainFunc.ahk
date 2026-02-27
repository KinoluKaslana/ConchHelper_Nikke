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
        checkbox := super.addCheckRow(mainGui, funcDescribe, optStr, ObjBindMethod(funcObj, "action"))

        settingBtn := mainGui.Add("Button", "HP W30 YP XM+" . (mainGuiWidth - 30), "⚙")
        settingBtn.OnEvent("Click", (settingBtn, eventInfo) => this.showSubFunc(funcDescribe))
        this.guiObj.push(settingBtn)

        this.subFuncMap[funcDescribe] := funcObj
    }

    init(mainGui, mainGuiWidth, optStr){
        shopObj := shop().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(shopObj)
        awardObj := award().regFunc(mainGui, "X280 Y35 W150 R1.2")
        this.subFuncObjArray.Push(awardObj)
        
        this.addCheckRow(mainGui, mainGuiWidth, shopObj, "商店", optStr)
        this.addCheckRow(mainGui, mainGuiWidth, awardObj, "奖励领取", "XS+5 YS+50 H30 W150")
    }

    regFunc(mainGui, mainGuiWidth, optStr){
        this.init(mainGui, mainGuiWidth, optStr)
        return this
    }
}