Private Sub Worksheet_SelectionChange(ByVal Target As Range)
  '//===========================  Function to highlight the entire rows of non blank cells from the active column
  If Target.Cells.Count > 1 Then Exit Sub

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
  ' This With ensures that when we make a new selection of an active cell, all the formatting we did is reverted
  With Target
    '   'Highlight row and column of the selected cell
    '   .EntireRow.Interior.ColorIndex = 38
    '   .EntireColumn.Interior.ColorIndex = 24

    '//===========================  Getting the variables to get the column range, like "B:B"
    Dim colNumber As Long
    Dim colLetter As String
    Dim colRange As String
    ' Get the column number of the active cell
    colNumber = ActiveCell.Column
    ' Convert column number to letter
    colLetter = Split(Cells(1, colNumber).Address, "$")(1)
    colRange = colLetter & ":" & colLetter
  
    '//===========================  Getting the cells and applying to each entire row of all the non blank cells highlighting
    Dim myRng As Range
    On Error Resume Next
    Set myRng = Range(colRange).SpecialCells(xlCellTypeConstants)
    For Each cell In myRng
      ' Change the interior color of each cell
      If IsNumeric(cell) Then cell.EntireRow.Interior.Color = RGB(230, 133, 201)
    Next cell
    
  End With
  
  Application.ScreenUpdating = True


End Sub

