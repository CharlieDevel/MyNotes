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

; Special selection mode enabled(the "g" keybind)
global shiftLockToggle := false

;/===========================  MOUSE controls
global multipleLinesJumpValue := 3
global numbersShortcutsEnabled := 0
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

$[::
{
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

    global numbersShortcutsEnabled
    if(numbersShortcutsEnabled == 0)
    {
        global numbersShortcutsEnabled := 1
        ToolTip("███Vim ON███`n███ mouse ███", 68, 100 )
        ;ToolTip("███Vim ON███`n███ arrows  ███", 68, 100 )
        return
    }
    if(numbersShortcutsEnabled == 1)
    {
        global numbersShortcutsEnabled := 0
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        return
    }
    if(numbersShortcutsEnabled == 2)
    {
        global numbersShortcutsEnabled := 0
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        return
    }
}

printMousePositions(lastKeyDirectionIsHorizontal)
{
    ; Defining variables to use
    ;MsgBox(xpos . "---" . ypos)
    MouseGetPos &xpos, &ypos 
    iterator := 1
    mouseDirectionXsign := 1
    if(mouseDirectionX < 0)
        mouseDirectionXsign := -1
    mouseDirectionYsign := 1
    if(mouseDirectionY < 0)
        mouseDirectionYsign := -1
    ;MsgBox("X: " mouseDirectionX "Y: " mouseDirectionY " --- X: " mouseDirectionXsign "Y: " mouseDirectionYsign " RESULT: " xpos+(mouseDirectionX*11*(mouseDirectionXsign)))

    ; Large positions
    if(lastKeyDirectionIsHorizontal = true)
        ToolTip("L", xpos+(mouseDirectionX*11), ypos, iterator)
    else
        ToolTip("L", xpos, ypos+(mouseDirectionY*11), iterator)

    iterator := iterator+1
    ; Short positions
    if(lastKeyDirectionIsHorizontal = true)
        ToolTip("s", xpos+(mouseDirectionX*4), ypos, iterator)
    else
        ToolTip("s", xpos, ypos+(mouseDirectionY*4), iterator)
}

toggleMousePositionsOff()
{
    ; Hide the mouse movement marks
    ToolTip("", , , 1)
    ToolTip("", , , 2)
    ToolTip("", , , 3)
    ToolTip("", , , 4)
}

;//===============  Rigth side to control the X axis
$1::
{
    if(numbersShortcutsEnabled = 0)
    {
        Send "1"
        return
    }

    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 0)
    {
        Send "{!}"
        return
    }

    ; Hold the mouse clik button
    if(numbersShortcutsEnabled = 1)
    {
        Click "Down"
        return
    }
}

$2::
{
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 0)
    {
        Send "3"
        return
    }

    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 0)
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
    if(numbersShortcutsEnabled = 0)
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
    if(numbersShortcutsEnabled = 0)
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
    if(numbersShortcutsEnabled = 0)
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
        global numbersShortcutsEnabled
        ToolTip("███Vim ON███`n███              ███", 68, 100 )
        if(numbersShortcutsEnabled = 0)
        {
            ToolTip("███Vim ON███`n███              ███", 68, 100 )
            return
        }
        if(numbersShortcutsEnabled = 11)
        {
            ToolTip("███Vim ON███`n███ arrows  ███", 68, 100 )
            return
        }
        if(numbersShortcutsEnabled = 1)
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
#SuspendExempt False

r::
{
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

$j::
{
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    if(numbersShortcutsEnabled = 1)
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
    global mouseDirectionX
    mouseDirectionX := 20

    if(numbersShortcutsEnabled = 1)
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
    global mouseDirectionX
    mouseDirectionX := -20

    if(numbersShortcutsEnabled = 1)
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
    Send "{Home}{Home}{Home}{Home}"
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

;Select everything inside comillas
$q::
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
        fileFavoriteLocationsString .= "Goto " . index . ": " . value . "::" . fileFavoriteLocationsTextualIdentifier[index] . "--"
        fileFavoriteLocationsString := RTrim(fileFavoriteLocationsString, "--") . "`n"
    }
    ; Remove the last newline (`n`)
    fileFavoriteLocationsString := RTrim(fileFavoriteLocationsString, "`n")
    ToolTip(fileFavoriteLocationsString, 190, 100 )
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


return
