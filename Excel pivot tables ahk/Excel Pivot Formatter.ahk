;WinActivate, FlowUML Viewpoints.xlsx - Excel ahk_class XLMAIN

; Se usa cuando se esta en un pivot table y se quiere que las celdas de la columna A(que contiene todas las filas del pivot table, y se tengan filas que tienen mucho texto y se quiera hacer que tengan Wrap Text) se aplique Wrap Text y antes de eso se aplique un resize del ancho de la columna A
timeBetweenClicks := 450
Sleep, 1320
; Click to anywhere
Click, 191, 227
Sleep, timeBetweenClicks
; Click to Home
Click, 77, 63 
Sleep, timeBetweenClicks
; Click to column A
Click, 191, 227
Sleep, timeBetweenClicks

; Click into format cells to make it wider
Click, 1392, 122
Sleep, timeBetweenClicks
; Click to Column Width
Click, 55, 101
Sleep, timeBetweenClicks
Send, {1}
Send, {9}
Send, {9}
Send, {Enter}
Sleep, timeBetweenClicks

; Click to Wrap Text
Click, 628, 101 
Sleep, 100
Click, 628, 101 
Sleep, timeBetweenClicks

; Making the sheet view be on top
Click, 63, 208
Send, {a}
Send, {3}
Send, {Enter}
Sleep, timeBetweenClicks

; Click to a cell to select all the ResourceDefinitions in the pivot table (This requires to have the cells in the pivot table to be indented to be just below the frozen sixth row)
;Click, 124, 409
Click, 111, 480
Sleep, timeBetweenClicks
; Click to indent cells
Click, 556, 141
Sleep, timeBetweenClicks
Click, 556, 141
Sleep, timeBetweenClicks

; Click into format cells
Click, 1392, 122
Sleep, timeBetweenClicks

; Click to Column Width
Click, 55, 101
Sleep, timeBetweenClicks
Send, {6}
Send, {6}
Send, {Enter}
Sleep, timeBetweenClicks
