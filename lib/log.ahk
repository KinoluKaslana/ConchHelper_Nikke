#Requires AutoHotkey v2.0
#Include "3rd\RichEdit.ahk"

class log{
    logBox := -1
    logBoxReady := false

    AddLog(text, color := "black") {
        ; 静态变量用于存储在 logBox 控件创建之前的日志
        static logBuffer := []
        ; 静态变量指示 logBox 是否已准备好
        ; 检查 logBox 是否已创建并准备好
        ; 使用 IsSet() 优先检查，避免对 unset 变量调用 IsObject() 报错
        ; 并且确保 logBox.Hwnd 存在，表示控件已实际创建
        if (!this.logBoxReady && IsObject(this.logBox) && this.logBox.Hwnd) {
            this.logBoxReady := true
            ; logBox 刚刚准备好，现在可以清空缓冲并写入
            if (logBuffer.Length > 0) {
                for bufferedLog in logBuffer {
                    this.AddLogToControl(bufferedLog.text, bufferedLog.color)
                }
                logBuffer := [] ; 清空缓冲
            }
        }
        ; 如果 logBox 已经准备好，则直接写入当前日志
        if (this.logBoxReady) {
            this.AddLogToControl(text, color)
        } else {
            ; 如果 logBox 尚未准备好，则将日志添加到缓冲
            logBuffer.Push({ text: text, color: color })
        }
    }
    ; 辅助函数：实际将日志写入 RichEdit 控件
    ; 这个函数不应该直接被外部调用，只由 AddLog 调用
    AddLogToControl(text, color) {
        ; 确保 logBox 控件存在且有效
        ; 理论上，由于 logBoxReady 检查，这里 logBox 应该总是有效的
        if (!IsObject(this.logBox) || !this.logBox.Hwnd) {
            ; 如果 logBox 意外地变得无效，可以打印到控制台或简单返回
            ; FileAppend "Error: AddLogToControl called with invalid logBox.`n", "*"
            return
        }
        ;静态变量保存上一条内容，这里应该在 AddLogToControl 内部，因为它是实际写入的函数
        static lastText := ""
        ;如果内容与上一条相同则跳过
        if (text = lastText)
            return
        lastText := text  ;保存当前内容供下次比较
        ; 将光标移到文本末尾
        this.logBox.SetSel(-1, -1)
        ; 保存当前选择位置
        sel := this.logBox.GetSel()
        start := sel.S
        ; 插入时间戳
        timestamp := FormatTime(, "HH:mm:ss")
        timestamp_text := timestamp "  "
        this.logBox.ReplaceSel(timestamp_text)
        ; 设置时间戳为灰色
        sel_before := this.logBox.GetSel()
        this.logBox.SetSel(start, start + StrLen(timestamp_text))
        font_gray := {}
        font_gray.Color := "gray"
        this.logBox.SetFont(font_gray)
        this.logBox.SetSel(sel_before.S, sel_before.S) ; 恢复光标位置
        ; 保存时间戳后的位置
        text_start := sel_before.S
        ; 插入文本内容
        this.logBox.ReplaceSel(text "`r`n")
        ; 计算文本内容的长度
        text_length := StrLen(text)
        ; 只选择文本内容部分（不包括时间戳）
        this.logBox.SetSel(text_start, text_start + text_length)
        ; 使用库提供的 SetFont 方法设置文本颜色
        font := {}
        font.Color := color
        this.logBox.SetFont(font)
        ; 设置悬挂缩进 - 使用段落格式
        PF2 := RichEdit.PARAFORMAT2()
        PF2.Mask := 0x05 ; PFM_STARTINDENT | PFM_OFFSET
        PF2.StartIndent := 0
        PF2.Offset := 940
        SendMessage(0x0447, 0, PF2.Ptr, this.logBox.Hwnd) ; EM_SETPARAFORMAT
        ; 取消选择并将光标移到底部
        this.logBox.SetSel(-1, -1)
        ; 自动滚动到底部
        this.logBox.ScrollCaret()
    }
    ;tag 日志的时间戳转换
    TimeToSeconds(timeStr) {
        ;期望 "HH:mm:ss" 格式
        parts := StrSplit(timeStr, ":")
        if (parts.Length != 3) {
            return -1 ;格式错误
        }
        ;确保部分是数字
        if (!IsInteger(parts[1]) || !IsInteger(parts[2]) || !IsInteger(parts[3])) {
            return -1 ;格式错误
        }
        hours := parts[1] + 0 ;强制转换为数字
        minutes := parts[2] + 0
        seconds := parts[3] + 0
        ;简单的验证范围（不严格）
        if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59 || seconds < 0 || seconds > 59) {
            return -1 ;无效时间
        }
        return hours * 3600 + minutes * 60 + seconds
    }

    init(mainGui, optStr){
        this.logBox := RichEdit(mainGui, optStr)
        this.logBox.WordWrap(true)
        this.AddLog("初始化Log框架")
        return this
    }
}

AddLog(text, color := "black"){
    static logObj := log()
    logObj.AddLog(text, color)
    return logObj
}