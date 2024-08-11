#NoEnv
#SingleInstance Force
SetBatchLines, -1
SetKeyDelay, 0, 50

#MaxHotkeysPerInterval 200000

scriptEnabled := false
doubleClick := false

; Define custom tray menu
Menu, Tray, NoStandard
Menu, Tray, Add, Dial set - 作者：Sekai, AuthorInfo
Menu, Tray, Add, 暂停热键, SuspendHotkeys
Menu, Tray, Add, 暂停脚本, PauseScript
Menu, Tray, Add, 退出脚本, ExitScript

^+!2::
if (scriptEnabled) {
    Send, {Left}
} else {
    Send, {WheelUp}
}
return

^+!1::
if (scriptEnabled) {
    Send, {Right}
} else {
    Send, {WheelDown}
}
return

F10::
if (doubleClick) {
    scriptEnabled := !scriptEnabled
    if (scriptEnabled) {
        TrayTip, Script Status, Script is now enabled, 1, 1
    } else {
        TrayTip, Script Status, Script is now disabled, 1, 1
    }
    doubleClick := false
} else {
    doubleClick := true
    SetTimer, HandleSingleClick, 300
}
return

HandleSingleClick:
if (doubleClick) {
    Send, {Space}
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

AuthorInfo:
return
