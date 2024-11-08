Private Sub Worksheet_SelectionChange(ByVal Target As Range)
  '//===========================  Function to highlight the entire columns of non blank cells from the active row, you must select at least 2 cells to enable this
  If Target.Cells.Count = 1 Then Exit Sub

  Static lastTimeCheckedSeconds As Double
  ' If the A:1 cell is empty, then clear everything and don't run
  If IsEmpty(Cells(1, 1)) Or (Timer - lastTimeCheckedSeconds < 0.5) Then
    Cells.Interior.ColorIndex = 0
    Exit Sub
  End If

  lastTimeCheckedSeconds = Timer
  Application.ScreenUpdating = False

  'Clear the color of all cells
  Cells.Interior.ColorIndex = 0
  'Clear the font color all cells
  Cells.Font.ColorIndex = xlColorIndexAutomatic

  ' This With ensures that when we make a new selection of an active cell, all the formatting we did is reverted
  With Target
    '   'Highlight row and column of the selected cell
    '   .EntireRow.Interior.ColorIndex = 38
    '   .EntireColumn.Interior.ColorIndex = 24

    '//===========================  Getting the variables to get the column range, like "B:B"
    Dim rowNumberString As String
    Dim rowLetter As String
    Dim rowRange As String
    ' Get the rowumn number of the active cell
    rowNumberString = CStr(ActiveCell.Row)
    rowRange = rowNumberString & ":" & rowNumberString

    '//===========================  Removing the letters from the selection range to only get the rows selection
    ' Dim letter As String
    ' Dim i As Integer
    
    ' rowRange = Selection.Address
    'MsgBox "Selection.Address: " & Selection.Address
    ' ' Loop through each letter of the alphabet
    ' For i = 65 To 90 ' ASCII values for A-Z
    '     letter = Chr(i) ' Convert ASCII value to letter
    '     rowRange = Replace(rowRange, letter, "")
    '     rowRange = Replace(rowRange, LCase(letter), "") ' Also handle lowercase letters
    '     rowRange = Replace(rowRange, "$", "") ' Also handle lowercase letters
    ' Next i
    ' 'MsgBox "rowRange: " & rowRange
    '//=====
  
    '//===========================  Getting the cells and applying to each entire row of all the non blank cells highlighting
    Dim myRng As Range
    On Error Resume Next
    Set myRng = Range(rowRange).SpecialCells(xlCellTypeConstants)
    For Each cell In myRng
      ' Change the interior Color of each cell
      If IsNumeric(cell) Then 
        cell.EntireColumn.Interior.Color = RGB(232, 182, 203)
        cell.Font.Color = RGB(255, 255, 240)
      End If

    Next cell
    
  End With
  
  Application.ScreenUpdating = True


End Sub

