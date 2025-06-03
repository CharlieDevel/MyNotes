ProcessSetPriority "RealTime"
A_HotkeyInterval := 4000
A_MaxHotkeysPerInterval := 200
SetKeyDelay 0

; VIM mode toggler
global capslockPressed := true
global timeToSleepForCopy := 150
global fileFavoriteLocations := Array()
global fileFavoriteLocationsActualLocation := Array()
global fileFavoriteLocationsTextualIdentifier := Array()
global fileFavoriteLocationsStartingFromHome := Array()
global favoriteWords := Array()
favoriteWords.Push(1)
favoriteWords.Push(2)
favoriteWords.Push(3)
favoriteWords.Push(4)
favoriteWords.Push(5)
favoriteWords.Push(6)
favoriteWords.Push(7)
favoriteWords.Push(8)
favoriteWords.Push(9)

; Special selection mode enabled(the "g" keybind)
global shiftLockToggle := false
global multipleLinesJumpValue := 2

;/===========================  MOUSE controls
global mousePrintMode := 2
global mouseModeEnabled := 0
global mousePowerIncrement := 1.45
global mouseScaler := 1
global mouseHorizontalButtonPressed := false
global mouseClickedDown := false

global mouseDirectionX := 20
global mouseDirectionXBase := mouseDirectionX
global mouseDirectionXKeepForward := 0
global mouseDirectionXKeepBackward := 0

global mouseDirectionY := 20
global mouseDirectionYBase := mouseDirectionY
global mouseDirectionYKeepForward := 0
global mouseDirectionYKeepBackward := 0

global mouseQwertyCurrentIndexPosition := 0
global qwertyEnable := 0
global originalMousePositionX := 0
global originalMousePositionY := 0
global mouseQwertyKeysSetSize := 5 ; The multiple is a way to define the 'groupings' of the positions to make for the mouse, like having an array of 15 and a multiple chosen of 5 would give 3 sets of 5 sub level locations we can travel
; Thse 2 variables will define the boundaries available for the currently selected set
global mouseQwertyKeysSetMinOffset := 1
global mouseQwertyKeysSetMaxOffset := mouseQwertyKeysSetSize
global mouseQwertyKeys := Array()
mouseQwertyKeys.Push("q")
mouseQwertyKeys.Push("w")
mouseQwertyKeys.Push("e")
mouseQwertyKeys.Push("r")
mouseQwertyKeys.Push("a")
mouseQwertyKeys.Push("s")
mouseQwertyKeys.Push("d")
mouseQwertyKeys.Push("f")
mouseQwertyKeys.Push("z")
mouseQwertyKeys.Push("x")
mouseQwertyKeys.Push("c")
mouseQwertyKeys.Push("v")
global mouseQwertyValues := Array()
mouseQwertyValues.Push("1")
mouseQwertyValues.Push("2")
mouseQwertyValues.Push("3")
mouseQwertyValues.Push("4")
mouseQwertyValues.Push("5")
mouseQwertyValues.Push("6")
mouseQwertyValues.Push("7")
mouseQwertyValues.Push("8")
mouseQwertyValues.Push("9")
mouseQwertyValues.Push("10")
mouseQwertyValues.Push("11")
mouseQwertyValues.Push("12")
mouseQwertyValues.Push("13")
mouseQwertyValues.Push("14")
mouseQwertyValues.Push("15")

$t::
{
    ; This defines what will be printed when the mouse mode is enabled, and thetool tip are printed, which can be just the 'L'arge and 's'mall tooltips, or the qwerty tool tips, or both
    if(mouseModeEnabled)
    {
        global mousePrintMode
        global mousePrintMode := mousePrintMode+1
        if(mousePrintMode > 2)
        {
            global mousePrintMode := 1
        }
        toggleMousePositionsOff()
        ToolTip("███Vim ON███`n███print=" mousePrintMode " ███", 68, 100 )
        return
    }
    global multipleLinesJumpValue
    global multipleLinesJumpValue := multipleLinesJumpValue+1
    if(multipleLinesJumpValue > 3)
    {
        global multipleLinesJumpValue := multipleLinesJumpValue+1
    }
    if(multipleLinesJumpValue > 7)
    {
        global multipleLinesJumpValue := 1
    }
    ToolTip("███Vim ON███`n███value=" multipleLinesJumpValue " ███", 68, 100 )
}

$.::
{
    toggleMousePositionsOff()

    global mouseModeEnabled
    if(mouseModeEnabled == 0)
    {
        global mouseModeEnabled := 1
        ToolTip("███Vim ON███`n███ mouse ███", 68, 100 )
        ;ToolTip("███Vim ON███`n███ arrows  ███", 68, 100 )
        return
    }
    if(mouseModeEnabled == 1)
    {
        global mouseModeEnabled := 0
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        return
    }
    if(mouseModeEnabled == 2)
    {
        global mouseModeEnabled := 0
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        return
    }
}

printMousePositions(lastKeyDirectionIsHorizontal, hasQwertyKeyBeenPressed := 0)
{
    ; Defining variables to use
    ;MsgBox(xpos . "---" . ypos)
    MouseGetPos &xpos, &ypos 

    ; This if is used to know if we should use new values as base(the mouse current position), or to keep the base values from previous mouse movements, those that came from 'u', 'n', 'l', or 'h' keys
    if(hasQwertyKeyBeenPressed)
    {
        xpos := originalMousePositionX
        ypos := originalMousePositionY
    }
    else
    {
        global originalMousePositionX
        global originalMousePositionX := xpos
        global originalMousePositionY
        global originalMousePositionY := ypos
    }

    iterator := mouseQwertyValues.Length+1
    mouseDirectionXsign := 1
    if(mouseDirectionX < 0)
        mouseDirectionXsign := -1
    mouseDirectionYsign := 1
    if(mouseDirectionY < 0)
        mouseDirectionYsign := -1
    ;MsgBox("X: " mouseDirectionX "Y: " mouseDirectionY " --- X: " mouseDirectionXsign "Y: " mouseDirectionYsign " RESULT: " xpos+(mouseDirectionX*11*(mouseDirectionXsign)))

    if(mousePrintMode = 1 and hasQwertyKeyBeenPressed = 0)
    {
        ; Qwerty positions
        global mouseQwertyValues
        global mouseQwertyKeys
        tooltipText := "."
        if(lastKeyDirectionIsHorizontal = true)
        {
            for qwertyIndex, value in mouseQwertyValues {
                tooltipText := SubStr("|.....#####||||||", Mod((qwertyIndex+1), mouseQwertyValues.Length), 1)
                mouseQwertyValues.RemoveAt(qwertyIndex)
                mouseQwertyValues.InsertAt(qwertyIndex, mouseDirectionX*qwertyIndex*3)
                ToolTip(tooltipText, xpos+(mouseQwertyValues[qwertyIndex]), ypos, qwertyIndex)
            }
        }
        else
        {
            for qwertyIndex, value in mouseQwertyValues {
                tooltipText := SubStr("|.....#####||||||", Mod((qwertyIndex+1), mouseQwertyValues.Length), 1)
                mouseQwertyValues.RemoveAt(qwertyIndex)
                mouseQwertyValues.InsertAt(qwertyIndex, mouseDirectionY*qwertyIndex*3)
                ToolTip(tooltipText, xpos, ypos+(mouseQwertyValues[qwertyIndex]), qwertyIndex)
            }
        }
    }


    if(mousePrintMode = 2)
    {
        PrintLargePositionsCount := 4
        PrintLargePositionsCountIterator := 1
        ; Large positions
        if (lastKeyDirectionIsHorizontal = true)
        {
            PrintLargePositionsCountIterator := 1
            ; Print the Large position multiple times
            loop (PrintLargePositionsCount)
            {
                ToolTip(PrintLargePositionsCountIterator, xpos + (mouseDirectionX*11*PrintLargePositionsCountIterator), ypos, PrintLargePositionsCountIterator+1)
                PrintLargePositionsCountIterator += 1
            }
        }
        else
        {
            PrintLargePositionsCountIterator := 1
            ; Print the Large position multiple times
            loop (PrintLargePositionsCount)
            {
                ToolTip(PrintLargePositionsCountIterator, xpos, ypos+(mouseDirectionY*11*PrintLargePositionsCountIterator), PrintLargePositionsCountIterator+1)
                PrintLargePositionsCountIterator += 1
            }
        }

        iterator := iterator+1
        ; Short positions
        if(lastKeyDirectionIsHorizontal = true)
            ToolTip("s", xpos+(mouseDirectionX*4), ypos, iterator)
        else
            ToolTip("s", xpos, ypos+(mouseDirectionY*4), iterator)
    }
}

Clamp(value, min, max) {
    return (value < min) ? min : (value > max) ? max : value
}

performMouseQwertyMovement(keyPressed)
{
    printMousePositions(mouseHorizontalButtonPressed, 1)

    global mouseQwertyCurrentIndexPosition
    global mouseQwertyKeysSetMinOffset
    global mouseQwertyKeysSetMaxOffset
    ; If the direction we are going is left specifically, then reverse left and right
    reverseDirection := 1
    ;if((mouseDirectionX <= 0 and (keyPressed = 1 or keyPressed = 2)) or (mouseDirectionY <= 0 and (keyPressed = 3 or keyPressed = 4)))
    if((mouseDirectionX <= 0 and mouseHorizontalButtonPressed))
        reverseDirection := -1
    ; This will decide wether to move inside the set confined(by default the first set, which e.g. if the whole locations count is 15, and a set size of 5, then we would have 5 available spaces to move in), or to a new set(following the example, we would be able to move to 3 sets)
    Switch keyPressed {
        Case 1: ; 'l' pressed, go left
        {
            mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition+(1*reverseDirection), 1, mouseQwertyValues.Length)
            ;mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition+(1*reverseDirection), mouseQwertyKeysSetMinOffset, mouseQwertyKeysSetMaxOffset)
        }
        Case 2: ; 'h' pressed, go right
        {
            mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition-(1*reverseDirection), 1, mouseQwertyValues.Length)
            ;mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition-(1*reverseDirection), mouseQwertyKeysSetMinOffset, mouseQwertyKeysSetMaxOffset)
        }
        Case 3: ; 'u' pressed, go to next set
        {
            mouseQwertyKeysSetMinOffset := Clamp(mouseQwertyKeysSetMinOffset+mouseQwertyKeysSetSize, 1, mouseQwertyValues.Length-mouseQwertyKeysSetSize)
            mouseQwertyKeysSetMaxOffset := Clamp(mouseQwertyKeysSetMaxOffset+mouseQwertyKeysSetSize, mouseQwertyKeysSetSize, mouseQwertyValues.Length)
            mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition+mouseQwertyKeysSetSize, 1, mouseQwertyValues.Length)
        }
        Case 4: ; 'n' pressed, go the previous set
        {
            mouseQwertyKeysSetMinOffset := Clamp(mouseQwertyKeysSetMinOffset-mouseQwertyKeysSetSize, 1, mouseQwertyValues.Length-mouseQwertyKeysSetSize)
            mouseQwertyKeysSetMaxOffset := Clamp(mouseQwertyKeysSetMaxOffset-mouseQwertyKeysSetSize, mouseQwertyKeysSetSize, mouseQwertyValues.Length)
            mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition-mouseQwertyKeysSetSize, 1, mouseQwertyValues.Length)
        }
        Default: ; default to 'l' pressed
        {
            mouseQwertyCurrentIndexPosition := Clamp(mouseQwertyCurrentIndexPosition+1, mouseQwertyKeysSetMinOffset, mouseQwertyKeysSetMaxOffset)
        }
    }

    ; Peform movement according to mouse array
    if(mouseHorizontalButtonPressed)
    {
        MouseMove(originalMousePositionX + mouseQwertyValues[Clamp(mouseQwertyCurrentIndexPosition, 1, mouseQwertyValues.Length)], originalMousePositionY)
         ;mouseQwertyValues[Clamp(mouseQwertyCurrentIndexPosition, 1, mouseQwertyValues.Length)], 0, 50, "R"
    }
    else
    {
        MouseMove(originalMousePositionX, originalMousePositionY + mouseQwertyValues[Clamp(mouseQwertyCurrentIndexPosition, 1, mouseQwertyValues.Length)])
        ;0, mouseQwertyValues[selectedIndex], 50, "R"
    }

}

toggleMousePositionsOff()
{
    ; Hide the mouse movement marks
    index := 1
    loop mouseQwertyValues.Length+3 {
        index += 1
        ToolTip("", , , index)
    }
}

;//===============  Rigth side to control the X axis
$1::
{
    if(mouseModeEnabled = 0)
    {
        Send "1"
        return
    }

    if(mouseModeEnabled = 1)
    {
        Send "{LButton}"
        return
    }

    ; Setting the base values to be used for movement
    global mouseDirectionX
    mouseDirectionX := 17*mouseScaler
    global mouseDirectionXBase
    mouseDirectionXBase := mouseDirectionX

    ; Perform basic movement
    MouseMove mouseDirectionX, 0, 50, "R"

    ; Reset going backward and forward
    global mouseDirectionXKeepBackward
    mouseDirectionXKeepBackward := 0
    global mouseDirectionXKeepForward
    mouseDirectionXKeepForward := 0
    printMousePositions(true)
}

$+1::
{
    if(mouseModeEnabled = 0)
    {
        Send "{!}"
        return
    }

    ; Hold the mouse clik button
    if(mouseModeEnabled = 1)
    {
        Click "Down"
        return
    }
}

$2::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            MouseMove mouseDirectionX, 0, 50, "R"
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY, 50, "R"
            printMousePositions(false)
        }
        return
    }

    Send "2"
}

$3::
{
    if(mouseModeEnabled = 0)
    {
        Send "3"
        return
    }

    if(mouseModeEnabled = 1)
    {
        Send "{RButton}"
        return
    }

    ; Setting the direction to go forward if the next key to press is the base key that goes backwards(to keep the flow)
    global mouseDirectionXKeepForward
    mouseDirectionXKeepForward := 2*mouseDirectionXBase

    ; Reset going backwards
    global mouseDirectionXKeepBackward
    mouseDirectionXKeepBackward := 0

    ; Accelerating the movement power
    ; Perform movement(which may be incremented)
    global mouseDirectionX
    if(mouseDirectionX > 0)
    {
        MouseMove mouseDirectionX*11, 0, 50, "R"
    }
    else
    {
        MouseMove mouseDirectionX*4, 0, 50, "R"
    }
    printMousePositions(true)
}

$4::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            MouseMove mouseDirectionX/2, 0, 50, "R"
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY/2, 50, "R"
            printMousePositions(false)
        }
        return
    }

    Send "4"
}

;//===============  Rigth side to control the Y axis
$7::
{
    if(mouseModeEnabled = 0)
    {
        Send "7"
        return
    }
    ; Setting the base values to be used for movement
    global mouseDirectionY
    mouseDirectionY := 17*mouseScaler
    global mouseDirectionYBase
    mouseDirectionYBase := mouseDirectionY

    ; Perform basic movement
    MouseMove 0, mouseDirectionY, 50, "R"

    ; Reset going backward and forward
    global mouseDirectionYKeepBackward
    mouseDirectionYKeepBackward := 0
    global mouseDirectionYKeepForward
    mouseDirectionYKeepForward := 0
    printMousePositions(false)
}

$8::
{
    if(mouseModeEnabled = 0)
    {
        Send "8"
        return
    }
    ; Setting the direction to go backwards if the next key to press is the base key that goes forward(to keep the flow)
    global mouseDirectionYKeepBackward
    mouseDirectionYKeepBackward := 2*mouseDirectionYBase
    
    ; Reset going forward
    global mouseDirectionYKeepForward
    mouseDirectionYKeepForward := 0

    ; Accelerating the movement power
    ; Perform movement(which may be incremented)
    global mouseDirectionY
    if(mouseDirectionY > 0)
    {
        MouseMove 0, mouseDirectionY*4, 50, "R"
    }
    else
    {
        MouseMove 0, mouseDirectionY*11, 50, "R"
    }
    printMousePositions(false)
}

$9::
{
    if(mouseModeEnabled = 0)
    {
        Send "9"
        return
    }

    ; Setting the direction to go forward if the next key to press is the base key that goes backwards(to keep the flow)
    global mouseDirectionYKeepForward
    mouseDirectionYKeepForward := 2*mouseDirectionYBase

    ; Reset going backwards
    global mouseDirectionYKeepBackward
    mouseDirectionYKeepBackward := 0

    ; Accelerating the movement power
    ; Perform movement(which may be incremented)
    global mouseDirectionY
    if(mouseDirectionY > 0)
    {
        MouseMove 0, mouseDirectionY*11, 50, "R"
    }
    else
    {
        MouseMove 0, mouseDirectionY*4, 50, "R"
    }
    printMousePositions(false)
}

$0::
{
    if(mouseModeEnabled = 0)
    {
        Send "0"
        return
    }

    ; Setting the base values to be used for movement
    global mouseDirectionY
    mouseDirectionY := -17*mouseScaler
    global mouseDirectionYBase
    mouseDirectionYBase := mouseDirectionY

    ; Perform basic movement
    MouseMove 0, mouseDirectionY, 50, "R"

    ; Reset going backward and forward
    global mouseDirectionYKeepForward
    mouseDirectionYKeepForward := 0
    global mouseDirectionYKeepBackward
    mouseDirectionYKeepBackward := 0
    printMousePositions(false)

}
;/===========================  


ShowMessage()
{
    if(capslockPressed)
    {
        global mouseModeEnabled
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        if(mouseModeEnabled = 0)
        {
            ToolTip("███Vim ON███`n███              ███", 68, 100 )
            return
        }
        if(mouseModeEnabled = 11)
        {
            ToolTip("███Vim ON███`n███ arrows  ███", 68, 100 )
            return
        }
        if(mouseModeEnabled = 1)
        {
            ToolTip("███Vim ON███`n███ mouse ███", 68, 100 )
            return
        }
    }
    else
    {
;        ToolTip("//===========================  Vim toggled OFF`n//===========================  Vim toggled OFF`n//===========================  Vim toggled OFF`r//===========================  Vim toggled OFF", 68, 123 )
        ToolTip("", 1, 1 )
    }
}

#SuspendExempt
toggleBinds()
{
    global capslockPressed
    capslockPressed := !capslockPressed

    global shiftLockToggle
    if(!capslockPressed)
    {
        if(shiftLockToggle)
            Send "{Blind}{LShift Up}"
        shiftLockToggle := false
    }
    Suspend
}

;Key that triggers the VIM mode
capslock::
{
    ;Toggle all binds off or on
    toggleBinds()

    toggleMousePositionsOff()

    ;SetCapsLockState capslockPressed
    ShowMessage()
}
;Key that triggers the VIM mode
!a::
{
    ;Toggle all binds off or on
    toggleBinds()

    toggleMousePositionsOff()

    ;SetCapsLockState capslockPressed
    ShowMessage()
}
#SuspendExempt False

r::
{
    if(mouseModeEnabled = 1)
    {
        performMouseQwertyMovement(3)
        return
    }

    ;aee := ControlGetFocus("A")
    ToolTip("", 1, 1 )
    ;ToolTip(WinGetTitle("A"), 1, 1 )
    ;MsgBox(WinGetTitle("A"))
    ;SendMessage(0x00b1, 1, 9, , WinGetTitle("A"))
    ;SendMessage(0x0115, 0, 0, , WinGetTitle("A"))


; ToolTip("X: " A_CaretX "Y: " A_CaretY, 1, 1 )
}

;If "g" was pressed, which enables another mode, and we want to get out of VIM mode, we must have this special keybind to first disable that mode enabled by "g"
+capslock::
{
    global shiftLockToggle
    shiftLockToggle := false
    Send "{Blind}{LShift Up}"
}

;Delete current word the cursor currently is
i::
{
    Send "+^{Left}"
    Send "{Backspace}"
}

\::
{
    Send "^{w}"
}

$j::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            if(mouseDirectionX > 0)
            {
                MouseMove mouseDirectionX*11, 0, 50, "R"
            }
            else
            {
                MouseMove mouseDirectionX*4, 0, 50, "R"
            }
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY*4, 50, "R"
            printMousePositions(false)
        }
        return
    }

    SendEvent "^{Left}" ; If the condition is met, send 'n'
}
+j::
{
    Send "+^{Left}"  ; Sends the Shift+Up key combination
}

$k::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseDirectionX > 0)
        {
            MouseMove mouseDirectionX*4, 0, 50, "R"
        }
        else
        {
            MouseMove mouseDirectionX*11, 0, 50, "R"
        }

        printMousePositions(true)
        return
    }
    
    SendEvent "^{Right}" ; If the condition is met, send 'n'
}
+k::
{
    Send "+^{Right}"  ; Sends the Shift+Up key combination
}

Up::
{
    Send "^{Up}"
}
Down::
{
    Send "^{Down}"
}
Right::
{
    Send "^{Right}"
}
Left::
{
    Send "^{Left}"
}

u::
{
    if(qwertyEnable)
    {
        performMouseQwertyMovement(3)
        return
    }

    global mouseQwertyCurrentIndexPosition
    global mouseQwertyCurrentIndexPosition := 0

    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionY
        mouseDirectionY := -17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := false

        ; Perform basic movement
        MouseMove 0, mouseDirectionY, 50, "R"

        ; Reset going backward and forward
        global mouseDirectionYKeepBackward
        mouseDirectionYKeepBackward := 0
        global mouseDirectionYKeepForward
        mouseDirectionYKeepForward := 0
        printMousePositions(false)
        return
    }
    Send "{Up}" ; If the condition is met, send 'n'
}
+u::
{
    Send "+{Up}"  ; Sends the Shift+Up key combination
}
^u::
{
    Send "^{Up}"  ; Sends the Shift+Up key combination
}
^+u::
{
    Send "^+{Up}"  ; Sends the Shift+Up key combination
}
y::
{
    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionY
        mouseDirectionY := -17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := false

        ; Perform basic movement
        MouseMove 0, mouseDirectionY*11, 50, "R"

        ; Reset going backward and forward
        global mouseDirectionYKeepBackward
        mouseDirectionYKeepBackward := 0
        global mouseDirectionYKeepForward
        mouseDirectionYKeepForward := 0
        printMousePositions(false)
        return
    }
    loop 5*multipleLinesJumpValue
    {
        Send "{Up}"  ; Sends the Shift+Up key combination
    }
}
+y::
{
    loop 5*multipleLinesJumpValue
    {
        Send "+{Up}"  ; Sends the Shift+Up key combination
    }
    return
}

n::
{
    if(qwertyEnable)
    {
        performMouseQwertyMovement(4)
        return
    }

    global mouseQwertyCurrentIndexPosition
    global mouseQwertyCurrentIndexPosition := 0

    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionY
        mouseDirectionY := 17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := false

        ; Perform basic movement
        MouseMove 0, mouseDirectionY, 50, "R"

        ; Reset going backward and forward
        global mouseDirectionYKeepBackward
        mouseDirectionYKeepBackward := 0
        global mouseDirectionYKeepForward
        mouseDirectionYKeepForward := 0
        printMousePositions(false)
        return
    }

    Send "{Down}" ; If the condition is met, send 'n'
}
+n::
{
    Send "+{Down}"  ; Sends the Shift+Up key combination
}
^n::
{   
    Send "^{Down}"  ; Sends the Shift+Up key combination
}
^+n::
{
    Send "^+{Down}"  ; Sends the Shift+Up key combination
}
b::
{
    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionY
        mouseDirectionY := 17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := false

        ; Perform basic movement
        MouseMove 0, mouseDirectionY*11, 50, "R"

        ; Reset going backward and forward
        global mouseDirectionYKeepBackward
        mouseDirectionYKeepBackward := 0
        global mouseDirectionYKeepForward
        mouseDirectionYKeepForward := 0
        printMousePositions(false)
        return
    }

    loop 5*multipleLinesJumpValue
    {
        Send "{Down}"  ; Sends the Shift+Up key combination
    }
}
+b::
{
    loop 5*multipleLinesJumpValue
    {
        Send "+{Down}"  ; Sends the Shift+Up key combination
    }
}

;//===========================   Left and Right binds

h::
{
    if(qwertyEnable)
    {
        performMouseQwertyMovement(2)
        return
    }

    global mouseQwertyCurrentIndexPosition
    global mouseQwertyCurrentIndexPosition := 0

    global mouseDirectionX
    mouseDirectionX := 20

    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionX
        mouseDirectionX := -17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := true

        ; Perform basic movement
        MouseMove mouseDirectionX, 0, 50, "R"

        printMousePositions(true)
        return
    }

    Send "{Left}" ; If the condition is met, send 'n'
}
+h::
{

    Send "+{Left}"  ; Sends the Shift+Up key combination
}

l::
{
    if(qwertyEnable)
    {
        performMouseQwertyMovement(1)
        return
    }

    global mouseQwertyCurrentIndexPosition
    global mouseQwertyCurrentIndexPosition := 0

    global mouseDirectionX
    mouseDirectionX := -20

    if(mouseModeEnabled = 1)
    {
        ; Setting the base values to be used for movement
        global mouseDirectionX
        mouseDirectionX := 17*mouseScaler
        global mouseHorizontalButtonPressed
        mouseHorizontalButtonPressed := true

        ; Perform basic movement
        MouseMove mouseDirectionX, 0, 50, "R"

        printMousePositions(true)
        return
    }

    Send "{Right}" ; If the condition is met, send 'n'
}
+l::
{
    Send "+{Right}"  ; Sends the Shift+Up key combination
}

;Translates to Alt+left
-::
{
    Send "!{Left}"
}
;Translates to Alt+right
=::
{
    Send "!{Right}"
}

;Translates to Shift+Tab
`::
{
    Send "+{Tab}"
}

;Translates to Ctrl+Tab
[::
{
    Send "^{Tab}"

}

;Translates to Shift+Ctrl+Tab
]::
{
    Send "^+{Tab}"

}

;//===========================   Copy paste binds
x::
{
    Send "^x"
}
;Done for the 'g' key which enables the shift key down until pressed again OR we copy, cut or paste
$+x::
{
    if(capslockPressed)
    {
        global shiftLockToggle
        shiftLockToggle := false
        Send "{Blind}{LShift Up}"
        Send "^x"
    }
}
c::
{
    Send "^c"
}
;Done for the 'g' key which enables the shift key down until pressed again OR we copy, cut or paste
$+c::
{
    if(capslockPressed)
    {
        global shiftLockToggle
        shiftLockToggle := false
        Send "{Blind}{LShift Up}"
        Send "^c"
    }
}
v::
{
    Send "^v"
}
;Done for the 'g' key which enables the shift key down until pressed again OR we copy, cut or paste
$+v::
{
    if(capslockPressed)
    {
        global shiftLockToggle
        shiftLockToggle := false
        Send "{Blind}{LShift Up}"
        Send "^v"
    }
}

z::
{
    Send "^z" ; If the condition is met, send 'n'
}
s::
{
    Send "^s" ; If the condition is met, send 'n'
}

;//===========================  end of line stuff
;Sets the cursor at the end of line
p::
{
    Send "+{End}{Right}"
}
;Sets the cursor in a new line below current line and exits pseudo vim mode
$+p::
{
    if(capslockPressed)
    {
        Send "{Home}+{End}{Right}{Enter}"
        toggleBinds()
        ToolTip("", 1, 1 )
    }
    else
        Send "{P}"  ; Sends the Shift+Up key combination
}
;Sends a ';' to the end of the current line regardless of the position
$;::
{
    Send "{Home}+{End}{Right};"
}

$^;::
{
    Send ";"
}

;//===========================  Replicating vim functionality
;Holds the shift key down to mimic vim select mode
;extra code was necessary for the +z, +x and +c keys, so that when in this mode, and doing any of those actions, it is smooth to exit the selection mode
g::
{
    global shiftLockToggle
    shiftLockToggle := true
    Send "{Home}{Right}{Home}{Home}"
    Send "{Blind}{LShift Down}"
}
;Unholds the shift key
+g::
{
    global shiftLockToggle
    shiftLockToggle := false
    Send "{Blind}{LShift Up}"
}

; Gets the input from the user and returns it as a number only if the input was a number, else it returns 0
GetUserInput(substactValue := 1) {
    toggleBinds()
    ih := InputHook("L1", "{Enter}{Esc}")
    ih.Start()
    ih.Wait()
    userInput := ih.Input
    occurenceChosen := 0
    toggleBinds()
    if(ih.Input == "")
    {
        ShowMessage()
        Exit
    }
    if(!IsInteger(ih.Input))
        occurenceChosen := 0
    else
        occurenceChosen := integer(ih.Input)-substactValue
    return occurenceChosen
}

;Select everything inside comillas, or move mouse in mouse mode
$q::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            MouseMove mouseDirectionX, 0, 50, "R"
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY, 50, "R"
            printMousePositions(false)
        }
        return
    }
    if(mouseModeEnabled = 1)
    {
        ;performMouseQwertyMovement(4)
        return
    }

    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        occurenceChosen := GetUserInput()
        loop 5
        {
            Send "+{Down}"
        }
        
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        comilla := Chr(34)
        stringInComilla := comilla . "([^" . comilla . "]+)" . comilla
        textt := StrReplace(textt, "`r", "")

        charactersToSkip := 1
        characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        ;===========================  Loop to go to the desired occurence according to the user input
        while(occurenceChosen > 0) {
            if(occurenceChosen > 0)
                occurenceChosen := occurenceChosen-1
                
            charactersToSkip := characters + StrLen(match[0])
            characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        }
        ;=====
        
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else    
        Send "q"
}
;Select everything inside backticks
$!q::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        occurenceChosen := GetUserInput()
        loop 5
        {
            Send "+{Down}"
        }
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        comilla := Chr(34)
        backtick := Chr(96)

        stringInComilla := backtick . "([^" . backtick . "]+)" . backtick
        ;stringInComilla := "\`([^\`]*)\`"
        textt := StrReplace(textt, "`r", "")

        charactersToSkip := 1
        characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        ;===========================  Loop to go to the desired occurence according to the user input
        while(occurenceChosen > 0) {
            if(occurenceChosen > 0)
                occurenceChosen := occurenceChosen-1
                
            charactersToSkip := characters + StrLen(match[0])
            characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        }
        ;=====
        
        ;MsgBox(match)
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "{Q}"
}
;Select everything inside SINGLE comillas
$+q::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        occurenceChosen := GetUserInput()
        loop 5
        {
            Send "+{Down}"
        }
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        comilla := Chr(34)
        singleComilla := Chr(39)

        stringInComilla := "'([^']*)'"
        ; "'(?:(?:[^']*)'){" . occurenceChosen . "}([^']*)" 
        textt := StrReplace(textt, "`r", "")

        charactersToSkip := 1
        characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        ;===========================  Loop to go to the desired occurence according to the user input
        while(occurenceChosen > 0) {
            if(occurenceChosen > 0)
                occurenceChosen := occurenceChosen-1
                
            charactersToSkip := characters + StrLen(match[0])
            characters := RegExMatch(textt, stringInComilla, &match, charactersToSkip)
        }
        ;=====
        
        ;MsgBox(match)
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "{Q}"
}
;Select Everything inside a parentheses
$w::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            MouseMove mouseDirectionX, 0, 50, "R"
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY, 50, "R"
            printMousePositions(false)
        }
        return
    }
    if(mouseModeEnabled = 1)
    {
        ;performMouseQwertyMovement(2)
        return
    }

    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        occurenceChosen := GetUserInput()
        loop 5
        {
            Send "+{Down}"
        }
        
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        stringInParenthesis := "\(((?>[^()]+)|(?R))*\)"
        textt := StrReplace(textt, "`r", "")

        charactersToSkip := 1
        characters := RegExMatch(textt, stringInParenthesis, &match, charactersToSkip)
        ;===========================  Loop to go to the desired occurence according to the user input
        while(occurenceChosen > 0) {
            if(occurenceChosen > 0)
                occurenceChosen := occurenceChosen-1
                
            charactersToSkip := characters + StrLen(match[0])
            characters := RegExMatch(textt, stringInParenthesis, &match, charactersToSkip)
        }
        ;=====
        
        ;MsgBox(match)
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }

        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "w"
}
;Select Everything inside brackets
+$w::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        loop 5
        {
            Send "+{Down}"
        }
        
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        stringInParenthesis := "\[((?>[^\[\]]+)|(?R))*\]"
        textt := StrReplace(textt, "`r", "")
        characters := RegExMatch(textt, stringInParenthesis, &match)
        
        ;MsgBox(match)
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }

        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "w"
}
;Select Everything inside curly braces
$e::
{
    if(mouseModeEnabled = 1)
    {
        ; Perform previous movement
        if(mouseHorizontalButtonPressed)
        {
            MouseMove mouseDirectionX, 0, 50, "R"
            printMousePositions(true)
        }
        else
        {
            MouseMove 0, mouseDirectionY, 50, "R"
            printMousePositions(false)
        }
        return
    }
    if(mouseModeEnabled = 1)
    {
        ;performMouseQwertyMovement(1)
        return
    }

    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        loop 7
        {
            Send "+{Down}"
        }
        
        Send "^c"
        sleep timeToSleepForCopy
        textt := A_Clipboard
        Send "{Left}"
        stringInParenthesis := "\{((?>[^{}]+)|(?R))*\}"
        textt := StrReplace(textt, "`r", "")
        characters := RegExMatch(textt, stringInParenthesis, &match)
        
        loop characters
        {
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len-2)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "e"
}
; Selects everything inside curly braces but able to reach until the end of the document
$+e::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        Send "{Home}+{End}{Right}{Right}{Up}"
        Send "^+{End}"

        Send "^c"
        sleep timeToSleepForCopy + 150
        textt := A_Clipboard
        Send "{Left}"
        stringInCurlyBraces := "\{((?>[^{}]+)|(?R))*\}"
        stringUntilOpeningCurlyBrace := "[^{]*"
        RegExMatch(textt, stringInCurlyBraces, &match)
        RegExMatch(textt, stringUntilOpeningCurlyBrace, &preMatch)
        
        if(match)
        {
            linesBeforeCurlyText := StrSplit(preMatch[0], "`r")
            numPreMatchLines := linesBeforeCurlyText.Length

            linesForCurlyText := StrSplit(match[0], "`r")
            numLines := linesForCurlyText.Length + numPreMatchLines -1
            loop (numLines)
            {
                Send "+{Down}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else
        Send "{E}"
}
PrintFilesSavedLocations()
{
    ; Initialize an empty string
    fileFavoriteLocationsString := ""
    ; Convert the nested array to a string
    for index, value in fileFavoriteLocationsActualLocation {
        fileFavoriteLocationsString .= "███ Goto {" . index . "}: " . value . "█: " . fileFavoriteLocationsTextualIdentifier[index] . "--"
        fileFavoriteLocationsString := RTrim(fileFavoriteLocationsString, "--") . "`n"
    }
    ; Remove the last newline (`n`)
    fileFavoriteLocationsString := RTrim(fileFavoriteLocationsString, "`n")
    ToolTip(fileFavoriteLocationsString, 190, 100 )
}
PrintFavoriteWords()
{
    ; Initialize an empty string
    favoriteWordsListString := ""
    ; Convert the nested array to a string
    for index, value in favoriteWords {
        textt := value
        ; Check if the value copied in the array has a length greater than 172 characters, if so, leave only the first 172 characters
        if (StrLen(value) > 172)
            ; Get first characters
            textt := SubStr(textt, 1, 172)
            ; Get last characters
            ;textt := SubStr(textt, -172)

        favoriteWordsListString .= "███ {" . index . "}█: " . textt . "`n"
    }
    ; Remove the last newline (`n`)
    favoriteWordsListString := RTrim(favoriteWordsListString, "`n")
    ToolTip(favoriteWordsListString, 190, 100 )
}
; Save the location of a file(store the line number we currently are in a text editor) to later access it when desired, you must enter a number between 0-9, where 0 will create a new entry to the files saved locations, and the others will add the location to a previously stored file
$^+j::
{
    ; Getting the entire file until user cursor
    originalClipboard := A_Clipboard

    ; Saving the current line to let the user recognize it easily
    Send "{Home}+{End}{Right}{Right}{Up}"
    Send "+{Down}+{Left}"
    Send "^c"
    sleep timeToSleepForCopy
    fileFavoriteLocationsTextualIdentifier.Push(A_Clipboard)

    ;//===========================   Getting the least number of lines to save the user's location
    Send "^+{Home}"
    Send "^c"
    sleep timeToSleepForCopy + 180
    textt := A_Clipboard
    Send "{Right}"
    ; Getting the location of the user
    StrReplace(textt, "`n", , , &linesCountFromHome)

    Send "^+{End}"
    Send "^c"
    sleep timeToSleepForCopy + 170
    textt := A_Clipboard
    Send "{Left}"
    ; Getting the location of the user
    StrReplace(textt, "`n", , , &linesCountFromEnd)
    ;=====

    linesCount := Min(linesCountFromHome, linesCountFromEnd)
    fileFavoriteLocationsStartingFromHome.Push(linesCountFromHome <= linesCountFromEnd)

    ; If the action of the user is to create a new file entry(i.e. 0) then do it
    fileFavoriteLocations.Push(linesCount)
    fileFavoriteLocationsActualLocation.Push(linesCountFromHome)

    A_Clipboard := originalClipboard
    ShowMessage()
}
; Go to the specified location according to the saved file
$^j::
{
    ; Getting the entire file until user cursor
    originalClipboard := A_Clipboard

    ; Make a toolTip window displaying all the saved files and their locations
    PrintFilesSavedLocations()
    desiredLocation := GetUserInput(0)
    ; If the location to go is 0(which is not real), then the user wants to erase a location, receive input and remove the specified index
    if(desiredLocation == 0)
    {
        indexToRemove := GetUserInput(0)
        fileFavoriteLocations.RemoveAt(indexToRemove)
        fileFavoriteLocationsActualLocation.RemoveAt(indexToRemove)
        fileFavoriteLocationsTextualIdentifier.RemoveAt(indexToRemove)
        fileFavoriteLocationsStartingFromHome.RemoveAt(indexToRemove)
        ShowMessage()
        return
    }
    ; If the location is approached from the begining of the file, then go some lines further
    if(fileFavoriteLocationsStartingFromHome[desiredLocation])
    {
        Send "^{Home}"
        ; Getting how many "PageDown" and "Down" keys to press
        Send "{PgDn}"
        Send "^+{Home}"
        Send "^c"
        sleep timeToSleepForCopy
        Send "{Left}"
        StrReplace(A_Clipboard, "`n", , , &linesInPageKey)
        pageDownPresses := Floor(fileFavoriteLocations[desiredLocation] / linesInPageKey)
        downArrowPresses := fileFavoriteLocations[desiredLocation] - (pageDownPresses*linesInPageKey)

        loop (pageDownPresses)
        {
            Send "{PgDn}"
        }
        loop (downArrowPresses)
        {
            Send "{Down}"
        }

        Send "{PgDn}"
        Send "{PgUp}"
    }
    else
    {
        Send "^{End}"
        ; Getting how many "PageUp" and "Up" keys to press
        Send "{PgUp}"
        Send "^+{End}"
        Send "^c"
        sleep timeToSleepForCopy
        Send "{Right}"
        StrReplace(A_Clipboard, "`n", , , &linesInPageKey)
        pageUpPresses := Floor(fileFavoriteLocations[desiredLocation] / linesInPageKey)
        upArrowPresses := fileFavoriteLocations[desiredLocation] - (pageUpPresses*linesInPageKey)

        loop (pageUpPresses)
        {
            Send "{PgUp}"
        }
        loop (upArrowPresses)
        {
            Send "{Up}"
        }

    }
    A_Clipboard := originalClipboard
    ShowMessage()
}
; This will receive an input press from 0-9, and will save the currently selected text to an array at the number pressed position
$+f9::
{
    Send "^c"
    PrintFavoriteWords()
    desiredWord := GetUserInput(0)
    favoriteWords.RemoveAt(desiredWord)
    favoriteWords.InsertAt(desiredWord, A_Clipboard)
    ShowMessage()
}
$f9::
{
    PrintFavoriteWords()
    desiredWord := GetUserInput(0)
    A_Clipboard := favoriteWords[desiredWord]
    Send "^v"
    ShowMessage()
}
;Selects a contiguous string as long as the next char is not a parentheses,
;bracket, curly braces or whitespace(this
;last thing forces you to be right before the word you want to select)
$d::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        Send "+{Down}"
        Send "^c"
        sleep 70
        textt := A_Clipboard
        Send "{Left}"
        contiguousString := "\S*?(?=[()\[\]{}\s])"

        textt := StrReplace(textt, "`r", "")
        lines := RegExMatch(textt, contiguousString, &match)
        
        loop (lines-1){
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else    
        Send "d"
}

;The same as the normal "d" bind but selects also the "(", "["  and everything within the parentheses or brackets
$+d::
{
    if(capslockPressed)
    {
        originalClipboard := A_Clipboard
        Send "+{Down}"
        Send "^c"
        sleep 85
        textt := A_Clipboard
        Send "{Left}"
        contiguousString := "(?:[^;\s()\[\]]+|\((?:[^()]+|(?R))*\)|\[(?:[^\[\]]+|(?R))*\])+"

        textt := StrReplace(textt, "`r", "")
        lines := RegExMatch(textt, contiguousString, &match)
        
        loop (lines-1){
            Send "{Right}" ; If the condition is met, send 'n'
        }
        if(match)
        {
            loop (match.Len)
            {
                Send "+{Right}" ; If the condition is met, send 'n'
            }
        }
        A_Clipboard := originalClipboard
    }
    else    
        Send "{D}"
}

;Finds the first occurence of any given character in the next lines and gets the cursor to that word
;This is applied to the FORWARD of the cursor, if input is started with "-" then it goes BACKWARDS instead
;If there are several matches in the text, then this gets into a new mode where we can 
;Switch between the found matches by pressing "h", "j"(to go to the left match) and "k", "l"(to go to the right match)
;After pressing a key different from the "left" and "right", then we exit VIM mode
f::
{
    if(mouseModeEnabled = 1)
    {
        performMouseQwertyMovement(8)
        return
    }

    ;Setting off all the hotkeys to be able to input them
    toggleBinds()

    ;Getting the key input from the user
    ih := InputHook("L2", "{Enter}{Esc}")
    ih.Start()
    ih.Wait()
    userInput := ih.Input
    global userInputLength := 0
    oldUserInputLength := userInputLength
    userInputLength := StrLen(userInput)
        ;MsgBox(ih.Input)
    if(ih.Input == "")
    {
        toggleBinds()
        return
    }

    goForward := 1
    ; If the first character is a "-", then the user wants to go search BACKWARDS
    if(SubStr(StrLower(ih.Input), 1, 1) == "-")
    {
        goForward := 0
        ih := InputHook("L1", "{Enter}{Esc}")
        ih.Start()
        ih.Wait()
        userInput := userInput . StrLower(ih.Input)
        ; We cut the first character which was only to change the search mode
        userInput := SubStr(StrLower(userInput), 2, 3)
        userInputLength := StrLen(userInput)
    }

    ;Perform search but using the last received input
    if(ih.Input == "ff")
    {
        PerformSearch()
        return
    }
    
    ;Converting the input to both lower case and upper case to add them into a single string
    user_inputLower1 := SubStr(StrLower(userInput), 1, 1)
    global regexToFind
    regexToFind := "(?i)" . user_inputLower1
    if(userInputLength > 1)
    {
        user_inputLower2 := SubStr(StrLower(userInput), 2, 1)
        regexToFind := "(?i)" . user_inputLower1 . user_inputLower2
    }
    PerformSearch(goForward)
}
; Perform a search but backwards
o::
{
    ;Setting off all the hotkeys to be able to input them
    toggleBinds()

    ;Getting the key input from the user
    ih := InputHook("L2", "{Enter}{Esc}")
    ih.Start()
    ih.Wait()
    userInput := ih.Input
    global userInputLength := 0
    oldUserInputLength := userInputLength
    userInputLength := StrLen(userInput)
        ;MsgBox(ih.Input)
    if(ih.Input == "")
    {
        toggleBinds()
        return
    }

    ;Perform search but using the last received input
    if(ih.Input == "ff")
    {
        PerformSearch(0)
        return
    }
    
    ;Converting the input to both lower case and upper case to add them into a single string
    user_inputLower1 := SubStr(StrLower(userInput), 1, 1)
    global regexToFind
    regexToFind := "(?i)" . user_inputLower1
    if(userInputLength > 1)
    {
        user_inputLower2 := SubStr(StrLower(userInput), 2, 1)
        regexToFind := "(?i)" . user_inputLower1 . user_inputLower2
    }
    PerformSearch(0)
}
; If the parameter is 1, then it will perform the search to the right and downards, if not then to the left and upwards
PerformSearch(goRight := 1) {
    ;Getting the text to analyze and moving the cursor there
    originalClipboard := A_Clipboard
    if(goRight == 1)
    {
        Send "+{Down}"
        Send "+{Down}"
        Send "+{Down}"
        Send "+{Down}"
        Send "+{Down}"
    }
    else
    {
        Send "+{Up}"
        Send "+{Up}"
        Send "+{Up}"
        Send "+{Up}"
        Send "+{Up}"
    }
    Send "^c"
    sleep timeToSleepForCopy-30
    textt := A_Clipboard
    if(goRight == 1)
        Send "{Left}"
    else
        Send "{Right}"

    textt := StrReplace(textt, "`r`n", "`n")
    texttLength := StrLen(textt)

    ;Getting all the possible matches and storing them in an array
    matches := Array()
    prevCharacters := 1
    characters := RegExMatch(textt, regexToFind, &match, prevCharacters)
    while (characters > 0) {
        matches.Push characters
        prevCharacters := characters + 1
        characters := RegExMatch(textt, regexToFind, &match, prevCharacters)
    }
    ;MsgBox(matches.Length)

    ;Setting the option to go to the desired match
    selectedMatch := 0
    if(goRight == 1)
        selectedMatch := 0
    else
        selectedMatch := matches.Length
    cursorPosition := 0
    pastMatch := 0
    accumulatedPosition := 0
    ih2 := InputHook("L1", "{Esc}{Backspace}")

    if(goRight == 0)
    {
        selectedMatch := selectedMatch
        if(matches.Length == 0)
        {
            toggleBinds()
            return
        }
        accumulatedPosition := matches[selectedMatch] - pastMatch
        pastMatch := matches[selectedMatch]
        ;MsgBox(texttLength)
        loop (texttLength - accumulatedPosition - 1) {
            Send "{Left}"
        }
    }
    ; This loop ensures every time we switch to a match, the cursor ends at the match correctly
    loop (userInputLength - 1) {
        Send "{Right}"
    }
    ; This if statemnet also aligns the cursor correctly but when going backwards
    if(goRight == 0)
        Send "{Left}"

    userInput := "d"
    ;Checking the user pressed "left" or "right" and moving to the selected match
    while ((userInput == "a" || userInput == "s" || userInput == "d" || userInput == "f") && userInput != "i") {
        if((userInput == "d" || userInput == "f") && selectedMatch != matches.Length) {
            selectedMatch := selectedMatch+1
            accumulatedPosition := matches[selectedMatch] - pastMatch
            pastMatch := matches[selectedMatch]
            loop (accumulatedPosition) {
                Send "{Right}"
            }
        }
        if((userInput == "a" || userInput == "s") && selectedMatch != 1) {
            selectedMatch := selectedMatch-1
            accumulatedPosition := pastMatch - matches[selectedMatch]
            pastMatch := matches[selectedMatch]
            loop (accumulatedPosition) {
                Send "{Left}"
            }
        }

        ;If there were no matches then end this while loop
        if(matches.Length < 1) {
            userInput := ""
            toggleBinds()   
        }
        else {
            ToolTip("███           ███`n██████ Match " selectedMatch "/"  matches.Length, 68, 123 )
            ih2.Start()
            ih2.Wait()
            userInput := ih2.Input
            ;MsgBox(userInput)
        }
    }

    A_Clipboard := originalClipboard
    if(userInput == "i") {
        Send "{Left}"
        Send "^{Right}"
        Send "+^{Left}"
        Send "{Backspace}"
        ;Send "^{Backspace}"
        toggleBinds()
    }
    if(userInput == "h") {
        Send "{Left}"
        toggleBinds()
    }
    if(userInput == "j") {
        SendEvent "^{Left}"
        toggleBinds()
    }
    if(userInput == "k") {
        SendEvent "^{Right}"
        toggleBinds()
    }
    if(userInput == "l") {
        Send "{Right}"
        toggleBinds()
    }
    if(userInput == "q") {
        toggleBinds()
    }
    ShowMessage()
}

;//===========================  Buffers to save text in f6, f7 and f8

global f6Buffer := ""
$+f6::
{
    Send "^c"
    sleep 70
    global f6Buffer
    f6Buffer := A_Clipboard
}
$f6::
{
    A_Clipboard := f6Buffer 
    Send "^v"
}

global f7Buffer := ""
$+f7::
{
    Send "^c"
    sleep 70
    global f7Buffer
    f7Buffer := A_Clipboard
}
$f7::
{
    A_Clipboard := f7Buffer 
    Send "^v"
}

global f8Buffer := ""
$+f8::
{
    Send "^c"
    sleep 70
    global f8Buffer
    f8Buffer := A_Clipboard
}
$f8::
{
    A_Clipboard := f8Buffer 
    Send "^v"
}

; Very special key which is supposed to be triggered in windws terminal, and have vscode as the second opened window, copies everything in the terminal, deletes all empty spaces, changes tab(into vscode), and pastes the text in the terminal
!o::
{
    ; The Suspend function is used to ensure we are able to press tings like '^n' and ensure it will actually be a hotkey for the vs code window and NOT press it with this hotkeys on(which will just do nothing)
    Suspend
    originalClipboard := A_Clipboard
    Send "^+a"
    ;MsgBox("    Send a+")
    Send "^c"
    sleep timeToSleepForCopy+200
    textt := A_Clipboard

    ; Normalizing line endings
    textt := StrReplace(textt, "`r`n", "`n")

    ; Deleting all empty spaces
    ;textt := StrReplace(textt, "`n`n`n", " ")
    ;textt := StrReplace(textt, "  ", " ")
    ; Check if the string length is greater than 9600 characters, if so, leave only the last 98k characters
    if (StrLen(textt) > 9600)
        textt := SubStr(textt, -9600)

    ;MsgBox("    Send Tab")
    ;Send "!{Tab}"
    ;WinActivate("ahk_class Chrome_WidgetWin_1")
    WinActivate("ahk_exe Code.exe")
    if (WinGetProcessName("A") = "Code.exe")
        Send "^+u"
    
    sleep timeToSleepForCopy+100
    ;A_Clipboard := textt
    A_Clipboard := "`n`n===========================  BLANK  ===========================`n===============================================================`n`n" . textt
    Send("!1")
    Send("^{End}")
    Send "^v"
    sleep timeToSleepForCopy
    A_Clipboard := originalClipboard
    Suspend
}

; Key that gets the current line, removes the part that probably come from a console, and pastes the string to a console window(only if this window was the last visited window)
!9::
{
    Suspend
    Send "{Home}{Right}{Home}{Home}"
    Send "+{Down}"
    ;Send "+{Left}" ; This is important to keep the regex working correctly only with what we care for
    Send "^c"
    sleep 70
    textt := A_Clipboard
    Send "{Left}"
    consolePartRegex := "(^((\s*).*?([#\$%❯➜→▶λ>~\)])|\s+)\s([#\$%❯➜→▶λ>~\)]\s+)?)"

    textt := StrReplace(textt, "`r", "")
    textt := RegExReplace(textt, consolePartRegex)
    
    ; MsgBox("textt: " textt "Clip: " A_Clipboard)
    WinActivate("ahk_exe WindowsTerminal.exe")
    ;Send("!{Tab}")
    A_Clipboard := textt
    Send "^v"
    sleep timeToSleepForCopy+70
    Suspend
}
return

$f1::
{
    Send("^!{Tab}")
}



