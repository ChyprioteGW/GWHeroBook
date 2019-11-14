#include-once

Global $GUI_RENDER = True
Opt("GUIOnEventMode", 1)

#Region GUI
#Region GUI
$GUI = GUICreate("CoF Farmer", 299, 212, -1, -1)
$LabelRuns = GUICtrlCreateLabel("Runs:", 6, 31, 31, 17)
$COUNT_RUNS = GUICtrlCreateLabel("0", 34, 31, 75, 17, $SS_RIGHT)
$FailsLabel = GUICtrlCreateLabel("Fails:", 6, 50, 31, 17)
$COUNT_FAILS = GUICtrlCreateLabel("0", 30, 50, 79, 17, $SS_RIGHT)
$LabelBones = GUICtrlCreateLabel("Bones:", 6, 69, 76, 17)
$COUNT_BONES = GUICtrlCreateLabel("0", 82, 69, 27, 17, $SS_RIGHT)
$LabelDusts = GUICtrlCreateLabel("Dusts:", 6, 88, 76, 17)
$COUNT_DUSTS = GUICtrlCreateLabel("0", 82, 88, 27, 17, $SS_RIGHT)
$LabelGolds = GUICtrlCreateLabel("Golds:", 6, 107, 76, 17)
$COUNT_GOLDS = GUICtrlCreateLabel("0", 82, 107, 27, 17, $SS_RIGHT)
$LabelAvgTime = GUICtrlCreateLabel("Average time:", 6, 126, 65, 17)
$AVERAGE_TIME = GUICtrlCreateLabel("-", 71, 126, 38, 17, $SS_RIGHT)
$LabelTotTime = GUICtrlCreateLabel("Total time:", 6, 145, 49, 17)
$TOTAL_TIME = GUICtrlCreateLabel("-", 55, 145, 54, 17, $SS_RIGHT)

$StatusLabel = GUICtrlCreateEdit("", 115, 6, 178, 200, 2097220)
$RenderingBox = GUICtrlCreateCheckbox("Disable Rendering", 6, 162, 103, 17)
    GUICtrlSetOnEvent(-1, "ToggleRendering")
    GUICtrlSetState($RenderingBox, $GUI_DISABLE)
GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUISetState(@SW_SHOW)
#EndRegion GUI

Func GUI()
    Global $GUI = GUICreate("Hero Book Bot", 300, 250, -1, -1)
    GUICtrlSetResizing($GUI, $GUI_DOCKALL)
    GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")

    $GUI_CHARSELECT = GUICtrlCreateCombo("", 5, 5, 100, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
        GUICtrlSetData($GUI_CHARSELECT, GetLoggedCharNames())
        GUICtrlSetOnEvent($GUI_CHARSELECT, "_load")
    $GUI_QUESTSELECT = GUICtrlCreateCombo("", 5, 35, 100, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
        GUICtrlSetData($GUI_QUESTSELECT, GetAvailableQuests())
        GUICtrlSetState($GUI_QUESTSELECT, $GUI_DISABLE)

    $GUI_STARTBUTTON = GUICtrlCreateButton("Start", 5, 215, 100, 25)
        GUICtrlSetOnEvent($GUI_STARTBUTTON, "_start")
        GUICtrlSetState($GUI_STARTBUTTON, $GUI_DISABLE)

    Global $GLOGBOX = GUICtrlCreateEdit("", 50, 50, 221, 225, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
    GUICtrlSetColor($GLOGBOX, 65280)
    GUICtrlSetBkColor($GLOGBOX, 0)

    Return $GUI
EndFunc ;GUI
#EndRegion GUI

#Region Helpers
Func Out($TEXT)
    GUICtrlSetData($GLOGBOX, GUICtrlRead($GLOGBOX) & "[" & @HOUR & ":" & @MIN & "] " & $TEXT & @CRLF)
    _GUICtrlEdit_Scroll($GLOGBOX, $SB_SCROLLCARET)
    _GUICtrlEdit_Scroll($GLOGBOX, $SB_LINEUP)
    UpdateLock()
EndFunc ;Out
Func GUITime()
    $time = TimerDiff($TIMER_TOTAL)
    GUICtrlSetData($GUI_LABEL_TIME, StringFormat("%03u:%02u", $time/1000/60, Mod($time/1000,60)))
EndFunc ;GUITime
#EndRegion Helpers

#Region Handlers

Func _exit()
    If $GUI_RENDER Then
        EnableRendering()
        WinSetState(GetWindowHandle(), "", @SW_SHOW)
        Sleep(500)
    EndIf
    Exit
 EndFunc
#EndRegion Handlers
