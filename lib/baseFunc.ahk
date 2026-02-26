#Requires AutoHotkey v2.0

class baseFunc {

    ;与GUI内check的事件有关，check的事件会将对应位置的job执行标志置1
    class job{
        ;0未计划 1就绪
        jobStatus := Array()
        jobFunc := Array()
        jobIndex := Map()

        addJob(describe, func){
            this.jobIndex[describe] := this.jobFunc.Length + 1
            MsgBox func.Name
            this.jobFunc.Push(func)
            this.jobStatus.Push(0)
        }
    }

    jobSet := baseFunc.job()
    guiObj := Array()

    ;子类不必实现，顺序执行job内所有函数
    action(){
        jobStatus := this.jobSet.jobStatus
        jobFunc := this.jobSet.jobFunc

        loop jobStatus.Length{
            if(jobStatus[A_Index] == 1){
                jobFunc[A_Index]()
            }
        }
    }

    toggleStatus(jobName){
        jobIndex := this.jobSet.jobIndex
        jobStatus := this.jobSet.jobStatus
        
        jobStatus[jobIndex[jobName]] := !jobStatus[jobIndex[jobName]]

        MsgBox jobName . " set to  " . jobStatus[jobIndex[jobName]]
    }

    addCheckRow(mainGui, describe, optStr, func){
        this.jobSet.addJob(describe, func)
        checkboxObj := mainGui.Add("CheckBox", optStr, describe)
        checkboxObj.OnEvent("Click", (checkboxObj, eventInfo) => this.toggleStatus(describe))
        this.guiObj.push(checkboxObj)
        return this.guiObj[-1]
    }

    hide(){
        guiObj := this.guiObj
        loop guiObj.Length
            guiObj[A_Index].Visible := false
    }

    show(){
        guiObj := this.guiObj
        loop guiObj.Length
            guiObj[A_Index].Visible := true
    }

    init(mainGui, optStr){

    }

    regFunc(mainGui, optStr){
        this.init(mainGui, optStr)
        this.hide()
        return this
    }
}