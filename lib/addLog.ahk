#Requires AutoHotkey v2.0
#Include <3rd\RichEdit>

class addLog{
    AddLog(text, color := "black") {
        ; 静态变量用于存储在 LogBox 控件创建之前的日志
        static logBuffer := []
        ; 静态变量指示 LogBox 是否已准备好
        static logBoxReady := false
        ; 检查 LogBox 是否已创建并准备好
        ; 使用 IsSet() 优先检查，避免对 unset 变量调用 IsObject() 报错
        ; 并且确保 LogBox.Hwnd 存在，表示控件已实际创建
        if (!logBoxReady && IsSet(LogBox) && IsObject(LogBox) && LogBox.Hwnd) {
            logBoxReady := true
            ; LogBox 刚刚准备好，现在可以清空缓冲并写入
            if (logBuffer.Length > 0) {
                for bufferedLog in logBuffer {
                    this.AddLogToControl(bufferedLog.text, bufferedLog.color)
                }
                logBuffer := [] ; 清空缓冲
            }
        }
        ; 如果 LogBox 已经准备好，则直接写入当前日志
        if (logBoxReady) {
            this.AddLogToControl(text, color)
        } else {
            ; 如果 LogBox 尚未准备好，则将日志添加到缓冲
            logBuffer.Push({ text: text, color: color })
        }
    }
    ; 辅助函数：实际将日志写入 RichEdit 控件
    ; 这个函数不应该直接被外部调用，只由 AddLog 调用
    AddLogToControl(text, color) {
        ; 确保 LogBox 控件存在且有效
        ; 理论上，由于 logBoxReady 检查，这里 LogBox 应该总是有效的
        if (!IsObject(LogBox) || !LogBox.Hwnd) {
            ; 如果 LogBox 意外地变得无效，可以打印到控制台或简单返回
            ; FileAppend "Error: AddLogToControl called with invalid LogBox.`n", "*"
            return
        }
        ;静态变量保存上一条内容，这里应该在 AddLogToControl 内部，因为它是实际写入的函数
        static lastText := ""
        ;如果内容与上一条相同则跳过
        if (text = lastText)
            return
        lastText := text  ;保存当前内容供下次比较
        ; 将光标移到文本末尾
        LogBox.SetSel(-1, -1)
        ; 保存当前选择位置
        sel := LogBox.GetSel()
        start := sel.S
        ; 插入时间戳
        timestamp := FormatTime(, "HH:mm:ss")
        timestamp_text := timestamp "  "
        LogBox.ReplaceSel(timestamp_text)
        ; 设置时间戳为灰色
        sel_before := LogBox.GetSel()
        LogBox.SetSel(start, start + StrLen(timestamp_text))
        font_gray := {}
        font_gray.Color := "gray"
        LogBox.SetFont(font_gray)
        LogBox.SetSel(sel_before.S, sel_before.S) ; 恢复光标位置
        ; 保存时间戳后的位置
        text_start := sel_before.S
        ; 插入文本内容
        LogBox.ReplaceSel(text "`r`n")
        ; 计算文本内容的长度
        text_length := StrLen(text)
        ; 只选择文本内容部分（不包括时间戳）
        LogBox.SetSel(text_start, text_start + text_length)
        ; 使用库提供的 SetFont 方法设置文本颜色
        font := {}
        font.Color := color
        LogBox.SetFont(font)
        ; 设置悬挂缩进 - 使用段落格式
        PF2 := RichEdit.PARAFORMAT2()
        PF2.Mask := 0x05 ; PFM_STARTINDENT | PFM_OFFSET
        PF2.StartIndent := 0
        PF2.Offset := 940
        SendMessage(0x0447, 0, PF2.Ptr, LogBox.Hwnd) ; EM_SETPARAFORMAT
        ; 取消选择并将光标移到底部
        LogBox.SetSel(-1, -1)
        ; 自动滚动到底部
        LogBox.ScrollCaret()
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
    ;tag 读取日志框内容 根据 HH:mm:ss 时间戳推算跨度，输出到日志框
    CalculateAndShowSpan(ExitReason := "", ExitCode := "") {
        global outputText
        logContent := LogBox.GetText()
        ; 使用正则表达式提取所有时间戳
        timestamps := []
        pos := 1
        match := ""
        while (pos := RegExMatch(logContent, "(?<time>\d{2}:\d{2}:\d{2})\s{2,}", &match, pos)) {
            timestamps.Push(match["time"])
            pos += match.Len
        }
        ; 检查是否有足够的时间戳
        if (timestamps.Length < 2) {
            this.AddLog("推算跨度失败：需要至少两个时间戳")
            return
        }
        earliestTimeStr := timestamps[1]
        latestTimeStr := timestamps[timestamps.Length]
        earliestSeconds := TimeToSeconds(earliestTimeStr)
        latestSeconds := TimeToSeconds(latestTimeStr)
        if (earliestSeconds = -1 || latestSeconds = -1) {
            tihs.AddLog("推算跨度失败：日志时间格式错误")
            return
        }
        ; 计算时间差（正确处理跨天）
        spanSeconds := latestSeconds - earliestSeconds
        ; 如果差值为负，说明可能跨天了
        if (spanSeconds < 0) {
            spanSeconds += 24 * 3600  ; 加上一天的秒数
        }
        spanMinutes := Floor(spanSeconds / 60)
        remainingSeconds := Mod(spanSeconds, 60)
        outputText := "已帮你节省时间: "
        if (spanMinutes > 0) {
            outputText .= spanMinutes " 分 "
        }
        outputText .= remainingSeconds " 秒"
        this.AddLog(outputText)
        if (spanSeconds < 5) {
            MsgBox("没怎么运行就结束了，任务列表勾了吗？还是没有进行详细的任务设置呢？")
        }
    }
}