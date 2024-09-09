#NoEnv
#SingleInstance Force
SetBatchLines, -1
SetKeyDelay, 0, 50
#MaxHotkeysPerInterval 233333

; 配置文件路径
defaultConfigFile := "default.ini"
customConfigFile := "Custom.ini"

; 默认键映射（初始默认值）
defaultInputKey1 := "^+!2"
defaultInputKey2 := "^+!1"
defaultInputKeyToggle := "F10"
defaultOutputKey1Enabled := "{Left}"
defaultOutputKey1Disabled := "{WheelUp}"
defaultOutputKey2Enabled := "{Right}"
defaultOutputKey2Disabled := "{WheelDown}"
defaultOutputKeyToggleEnabled := "{Space}"

; 初始化配置
if !FileExist(defaultConfigFile) {
    SaveConfig(defaultConfigFile) ; 保存默认配置到 default.ini
}

; 载入配置文件
if FileExist(customConfigFile) {
    LoadConfig(customConfigFile)
} else {
    LoadConfig(defaultConfigFile)
}

; 设置热键
SetHotkeys()

; 自定义托盘菜单
Menu, Tray, NoStandard
Menu, Tray, Add, 脚本开关, PauseScript
Menu, Tray, Add, 设置, ShowSettings
Menu, Tray, Add, 退出, ExitScript

return

ShowSettings:
Gui, New, +AlwaysOnTop +Resize +ToolWindow, 设置
Gui, Font, s10, Segoe UI
Gui, Color, F7F7F7
Gui, Margin, 15, 15

; 设置窗口尺寸为的比例
Gui, Show, w400 h400, 设置  ; 调整窗口大小以达到的长宽比

; 区域1（系统设置）
Gui, Add, Text, xm, 区域1（系统设置）
Gui, Add, Text, xm, 
Gui, Add, Text, xm+10 yp+10, 左旋快捷方式:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkey2, %inputKey2%
Gui, Add, Text, xm+10 yp+25, 右旋快捷方式:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkey1, %inputKey1%
Gui, Add, Text, xm+10 yp+25, 单击快捷方式:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkeyToggle, %inputKeyToggle%


; 分隔线
Gui, Add, Text, xm, ────────────────────────

; 区域2（自定义设置）
Gui, Add, Text, xm, 区域2（自定义设置）
Gui, Add, Text, xm
Gui, Add, Text, xm+10 yp+10, 模式1左旋转:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey1Disabled, %outputKey1Disabled%
Gui, Add, Text, xm+10 yp+25, 模式1右旋转:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey2Disabled, %outputKey2Disabled%
Gui, Add, Text, xm+10 yp+25, 模式2左旋转:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey1Enabled, %outputKey1Enabled%
Gui, Add, Text, xm+10 yp+25, 模式2右旋转:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey2Enabled, %outputKey2Enabled%
Gui, Add, Text, xm+4 yp+25, 自定义单击键:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkeyToggleEnabled, %outputKeyToggleEnabled%

; 保存与重置按钮
Gui, Add, Button, xm w180 h30 gSaveCustomSettings, 保存自定义配置
Gui, Add, Button, x+10 w180 h30 gDeleteCustomConfig, 重置为默认配置
Gui, Show,, 设置
return

SaveCustomSettings:
Gui, Submit
inputKey1 := InputHotkey1
inputKey2 := InputHotkey2
inputKeyToggle := InputHotkeyToggle
outputKey1Enabled := OutputHotkey1Enabled
outputKey1Disabled := OutputHotkey1Disabled
outputKey2Enabled := OutputHotkey2Enabled
outputKey2Disabled := OutputHotkey2Disabled
outputKeyToggleEnabled := OutputHotkeyToggleEnabled

; 保存自定义配置到 Custom.ini
SaveConfig(customConfigFile)

SetHotkeys()

; 显示保存成功提示
MsgBox, 64,配置已保存,点击“确定”以重新启动脚本!（如果修改区域1请确保系统中一致）

; 重启脚本
if A_IsCompiled {
    Run, %A_ScriptFullPath%  ; 如果是编译的 exe 文件，重新运行自身
} else {
    Reload  ; 如果是 .ahk 文件，重新加载脚本
}

ExitApp  ; 退出当前实例

Gui, Destroy
return

DeleteCustomConfig:
IfExist, %customConfigFile%
{
    FileDelete, %customConfigFile%
    MsgBox, 自定义配置已删除，使用默认配置,请关闭重新打开脚本并在系统中修改按键。
    LoadConfig(defaultConfigFile) ; 重新加载默认配置
    SetHotkeys() ; 更新热键设置
}
Gui, Destroy
return

; 保存配置到指定文件
SaveConfig(file) {
    global inputKey1, inputKey2, inputKeyToggle
    global outputKey1Enabled, outputKey1Disabled
    global outputKey2Enabled, outputKey2Disabled
    global outputKeyToggleEnabled

    IniWrite, %inputKey1%, %file%, Hotkeys, InputKey1
    IniWrite, %inputKey2%, %file%, Hotkeys, InputKey2
    IniWrite, %inputKeyToggle%, %file%, Hotkeys, InputKeyToggle
    IniWrite, %outputKey1Enabled%, %file%, Hotkeys, OutputKey1Enabled
    IniWrite, %outputKey1Disabled%, %file%, Hotkeys, OutputKey1Disabled
    IniWrite, %outputKey2Enabled%, %file%, Hotkeys, OutputKey2Enabled
    IniWrite, %outputKey2Disabled%, %file%, Hotkeys, OutputKey2Disabled
    IniWrite, %outputKeyToggleEnabled%, %file%, Hotkeys, OutputKeyToggleEnabled
}

; 载入配置文件
LoadConfig(file) {
    global inputKey1, inputKey2, inputKeyToggle
    global outputKey1Enabled, outputKey1Disabled
    global outputKey2Enabled, outputKey2Disabled
    global outputKeyToggleEnabled
    global defaultInputKey1, defaultInputKey2, defaultInputKeyToggle
    global defaultOutputKey1Enabled, defaultOutputKey1Disabled
    global defaultOutputKey2Enabled, defaultOutputKey2Disabled
    global defaultOutputKeyToggleEnabled

    ; 读取配置文件中的值或使用默认值
    IniRead, inputKey1, %file%, Hotkeys, InputKey1, %defaultInputKey1%
    IniRead, inputKey2, %file%, Hotkeys, InputKey2, %defaultInputKey2%
    IniRead, inputKeyToggle, %file%, Hotkeys, InputKeyToggle, %defaultInputKeyToggle%
    IniRead, outputKey1Enabled, %file%, Hotkeys, OutputKey1Enabled, %defaultOutputKey1Enabled%
    IniRead, outputKey1Disabled, %file%, Hotkeys, OutputKey1Disabled, %defaultOutputKey1Disabled%
    IniRead, outputKey2Enabled, %file%, Hotkeys, OutputKey2Enabled, %defaultOutputKey2Enabled%
    IniRead, outputKey2Disabled, %file%, Hotkeys, OutputKey2Disabled, %defaultOutputKey2Disabled%
    IniRead, outputKeyToggleEnabled, %file%, Hotkeys, OutputKeyToggleEnabled, %defaultOutputKeyToggleEnabled%

    ; 检查值是否为空，如果为空，则使用默认值
    if (inputKey1 = "") {
        inputKey1 := defaultInputKey1
    }
    if (inputKey2 = "") {
        inputKey2 := defaultInputKey2
    }
    if (inputKeyToggle = "") {
        inputKeyToggle := defaultInputKeyToggle
    }
    if (outputKey1Enabled = "") {
        outputKey1Enabled := defaultOutputKey1Enabled
    }
    if (outputKey1Disabled = "") {
        outputKey1Disabled := defaultOutputKey1Disabled
    }
    if (outputKey2Enabled = "") {
        outputKey2Enabled := defaultOutputKey2Enabled
    }
    if (outputKey2Disabled = "") {
        outputKey2Disabled := defaultOutputKey2Disabled
    }
    if (outputKeyToggleEnabled = "") {
        outputKeyToggleEnabled := defaultOutputKeyToggleEnabled
    }
}

; 设置热键
SetHotkeys() {
    global inputKey1, inputKey2, inputKeyToggle
    Hotkey, %inputKey1%, HandleInput1, On
    Hotkey, %inputKey2%, HandleInput2, On
    Hotkey, %inputKeyToggle%, HandleToggle, On
}

; 定义热键处理函数
HandleInput1:
if (scriptEnabled) {
    Send, %outputKey1Enabled%
} else {
    Send, %outputKey1Disabled%
}
return

HandleInput2:
if (scriptEnabled) {
    Send, %outputKey2Enabled%
} else {
    Send, %outputKey2Disabled%
}
return

HandleToggle:
if (doubleClick) {
    scriptEnabled := !scriptEnabled
    if (scriptEnabled) {
        TrayTip, 切换, 模式2, 1, 1
    } else {
        TrayTip, 切换, 模式1, 1, 1
    }
    doubleClick := false
} else {
    doubleClick := true
    SetTimer, HandleSingleClick, 300
}
return

HandleSingleClick:
if (doubleClick) {
    Send, %outputKeyToggleEnabled%
    doubleClick := false
}
return

SuspendHotkeys:
Suspend
return

PauseScript:
Pause
return

ExitScript:
ExitApp
return

OpenGitHub:
Run, https://github.com/Sekai219
return