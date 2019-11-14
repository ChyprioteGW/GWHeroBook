
#include "../GWA2.au3"
#include <SimpleInventory.au3>

#Region Constants
Global $FILE = @ScriptDir & "Trace-" & @MDAY & @MON & @HOUR & @MIN & ".txt"
Global $IS_RUNNING = False
Global $IS_INITIALIZED = False
Global $HARD_MODE = False
Global $TOTAL_RUNS = 0
Global $MAP_TO_ZONE, $TIMER_TOTAL
#EndRegion

#cs
    Select character
    Select quest
    Use HM - Start

    #Toggle Render
#ce

#Region Main loop
FileOpen($FILE)
Log("Bot started")
While 1
    sleep(200)
    If Not $IS_RUNNING Then ContinueLoop

    ;Stop if we can't reach the outpost
    If Not TravelToOutpost() Then
        $IS_RUNNING = False
        ContinueLoop
    EndIf

    ;Initialize bot
    If Not $IS_INITIALIZED Then
        AdlibRegister("GUITime", 1000)
        AdlibRegister("VerifyConnection", 5000)
        $TIMER_TOTAL = TimerInit()
        SwitchMode($HARD_MODE)
    EndIf

    Switch($SELECTED_QUEST)
        Case :
    EndSwitch

    TravelToOutpost()
    Inventory()
WEnd
#EndRegion Main Loop


#Region Actions
Func TravelToOutpost()
    Log("Traveling to outpost " & $MAP_TO_ZONE)
    If GetMapID() == $MAP_TO_ZONE Then Return True

    Out("Moving to Outpost")
    If Not TravelTo($MAP_TO_ZONE) Then
        Log("Script stopped because unable to reach outpost")
        MsgBox(48, "Warnning", "Unable to travel to the required outpost.")
        Return False
    EndIf

    RndSleep(1000)
    Return True
EndFunc ;TravelToOutpost
#EndRegion Actions

#Region Helpers
Func Log($msg)
    FileWriteLine($FILE, "[" & @HOUR & ":" & @MIN & "] " & $msg & @CRLF)
EndFunc ;Log

Func VerifyConnection()
    If GetMapLoading() == 2 Then Disconnected()
EndFunc ;VerifyConnection
#EndRegion Helpers
