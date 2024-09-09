#NoEnv
#SingleInstance Force
SetBatchLines, -1
SetKeyDelay, 0, 50
#MaxHotkeysPerInterval 233333

; �����ļ�·��
defaultConfigFile := "default.ini"
customConfigFile := "Custom.ini"

; Ĭ�ϼ�ӳ�䣨��ʼĬ��ֵ��
defaultInputKey1 := "^+!2"
defaultInputKey2 := "^+!1"
defaultInputKeyToggle := "F10"
defaultOutputKey1Enabled := "{Left}"
defaultOutputKey1Disabled := "{WheelUp}"
defaultOutputKey2Enabled := "{Right}"
defaultOutputKey2Disabled := "{WheelDown}"
defaultOutputKeyToggleEnabled := "{Space}"

; ��ʼ������
if !FileExist(defaultConfigFile) {
    SaveConfig(defaultConfigFile) ; ����Ĭ�����õ� default.ini
}

; ���������ļ�
if FileExist(customConfigFile) {
    LoadConfig(customConfigFile)
} else {
    LoadConfig(defaultConfigFile)
}

; �����ȼ�
SetHotkeys()

; �Զ������̲˵�
Menu, Tray, NoStandard
Menu, Tray, Add, �ű�����, PauseScript
Menu, Tray, Add, ����, ShowSettings
Menu, Tray, Add, �˳�, ExitScript

return

ShowSettings:
Gui, New, +AlwaysOnTop +Resize +ToolWindow, ����
Gui, Font, s10, Segoe UI
Gui, Color, F7F7F7
Gui, Margin, 15, 15

; ���ô��ڳߴ�Ϊ�ı���
Gui, Show, w400 h400, ����  ; �������ڴ�С�Դﵽ�ĳ����

; ����1��ϵͳ���ã�
Gui, Add, Text, xm, ����1��ϵͳ���ã�
Gui, Add, Text, xm, 
Gui, Add, Text, xm+10 yp+10, ������ݷ�ʽ:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkey2, %inputKey2%
Gui, Add, Text, xm+10 yp+25, ������ݷ�ʽ:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkey1, %inputKey1%
Gui, Add, Text, xm+10 yp+25, ������ݷ�ʽ:
Gui, Add, Hotkey, x+120 yp-2 vInputHotkeyToggle, %inputKeyToggle%


; �ָ���
Gui, Add, Text, xm, ������������������������������������������������

; ����2���Զ������ã�
Gui, Add, Text, xm, ����2���Զ������ã�
Gui, Add, Text, xm
Gui, Add, Text, xm+10 yp+10, ģʽ1����ת:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey1Disabled, %outputKey1Disabled%
Gui, Add, Text, xm+10 yp+25, ģʽ1����ת:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey2Disabled, %outputKey2Disabled%
Gui, Add, Text, xm+10 yp+25, ģʽ2����ת:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey1Enabled, %outputKey1Enabled%
Gui, Add, Text, xm+10 yp+25, ģʽ2����ת:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkey2Enabled, %outputKey2Enabled%
Gui, Add, Text, xm+4 yp+25, �Զ��嵥����:
Gui, Add, Hotkey, x+120 yp-2 vOutputHotkeyToggleEnabled, %outputKeyToggleEnabled%

; ���������ð�ť
Gui, Add, Button, xm w180 h30 gSaveCustomSettings, �����Զ�������
Gui, Add, Button, x+10 w180 h30 gDeleteCustomConfig, ����ΪĬ������
Gui, Show,, ����
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

; �����Զ������õ� Custom.ini
SaveConfig(customConfigFile)

SetHotkeys()

; ��ʾ����ɹ���ʾ
MsgBox, 64,�����ѱ���,�����ȷ���������������ű�!������޸�����1��ȷ��ϵͳ��һ�£�

; �����ű�
if A_IsCompiled {
    Run, %A_ScriptFullPath%  ; ����Ǳ���� exe �ļ���������������
} else {
    Reload  ; ����� .ahk �ļ������¼��ؽű�
}

ExitApp  ; �˳���ǰʵ��

Gui, Destroy
return

DeleteCustomConfig:
IfExist, %customConfigFile%
{
    FileDelete, %customConfigFile%
    MsgBox, �Զ���������ɾ����ʹ��Ĭ������,��ر����´򿪽ű�����ϵͳ���޸İ�����
    LoadConfig(defaultConfigFile) ; ���¼���Ĭ������
    SetHotkeys() ; �����ȼ�����
}
Gui, Destroy
return

; �������õ�ָ���ļ�
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

; ���������ļ�
LoadConfig(file) {
    global inputKey1, inputKey2, inputKeyToggle
    global outputKey1Enabled, outputKey1Disabled
    global outputKey2Enabled, outputKey2Disabled
    global outputKeyToggleEnabled
    global defaultInputKey1, defaultInputKey2, defaultInputKeyToggle
    global defaultOutputKey1Enabled, defaultOutputKey1Disabled
    global defaultOutputKey2Enabled, defaultOutputKey2Disabled
    global defaultOutputKeyToggleEnabled

    ; ��ȡ�����ļ��е�ֵ��ʹ��Ĭ��ֵ
    IniRead, inputKey1, %file%, Hotkeys, InputKey1, %defaultInputKey1%
    IniRead, inputKey2, %file%, Hotkeys, InputKey2, %defaultInputKey2%
    IniRead, inputKeyToggle, %file%, Hotkeys, InputKeyToggle, %defaultInputKeyToggle%
    IniRead, outputKey1Enabled, %file%, Hotkeys, OutputKey1Enabled, %defaultOutputKey1Enabled%
    IniRead, outputKey1Disabled, %file%, Hotkeys, OutputKey1Disabled, %defaultOutputKey1Disabled%
    IniRead, outputKey2Enabled, %file%, Hotkeys, OutputKey2Enabled, %defaultOutputKey2Enabled%
    IniRead, outputKey2Disabled, %file%, Hotkeys, OutputKey2Disabled, %defaultOutputKey2Disabled%
    IniRead, outputKeyToggleEnabled, %file%, Hotkeys, OutputKeyToggleEnabled, %defaultOutputKeyToggleEnabled%

    ; ���ֵ�Ƿ�Ϊ�գ����Ϊ�գ���ʹ��Ĭ��ֵ
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

; �����ȼ�
SetHotkeys() {
    global inputKey1, inputKey2, inputKeyToggle
    Hotkey, %inputKey1%, HandleInput1, On
    Hotkey, %inputKey2%, HandleInput2, On
    Hotkey, %inputKeyToggle%, HandleToggle, On
}

; �����ȼ�������
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
        TrayTip, �л�, ģʽ2, 1, 1
    } else {
        TrayTip, �л�, ģʽ1, 1, 1
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