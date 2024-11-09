' Declare the colorDict as a global variable at the module level
Dim colorDict As Object

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
        '//===========================  Getting the variables to get the column range, like "B:B"
        Dim rowNumberString As String
        Dim rowLetter As String
        Dim rowRange As String
        ' Get the row number of the active cell
        rowNumberString = CStr(ActiveCell.Row)
        rowRange = rowNumberString & ":" & rowNumberString

        '//===========================  Getting the cells and applying to each entire row of all the non blank cells highlighting
        Dim myRng As Range
        Dim currentCellValue As Variant
        Dim maximumCellValue As Variant
        Dim r As Integer, g As Integer, b As Integer

        On Error Resume Next
        Set myRng = Range(rowRange).SpecialCells(xlCellTypeConstants)
        On Error GoTo 0 ' Reset error handling to default

        ' If colorDict is not initialized, create a new instance
        If colorDict Is Nothing Then
            Set colorDict = CreateObject("Scripting.Dictionary")
        End If

        ' Loop through each non-blank cell
        For Each cell In myRng
            ' If the value is numeric, process it
            If IsNumeric(cell.Value) Then
                currentCellValue = cell.Value
                maximumCellValue = Application.WorksheetFunction.Max(myRng)
                  ' Check if the value is already in the dictionary
                  If Not colorDict.exists(currentCellValue) Then
                      ' If not, calculate RGB values and store them
                      Call AdjustColorIntensity(currentCellValue, maximumCellValue, r, g, b)
                      colorDict.Add currentCellValue, Array(r, g, b)
                  Else
                      ' Retrieve the RGB values from the dictionary
                      r = colorDict(currentCellValue)(0)
                      g = colorDict(currentCellValue)(1)
                      b = colorDict(currentCellValue)(2)
                  End If

                ' Apply the calculated or default color to the cell
                cell.EntireColumn.Interior.Color = RGB(r, g, b)
                cell.Font.Color = RGB(255, 255, 240)
            End If
        Next cell

        ' Clear or reset the background color in Column A, for the cases where it was colored and has an annoying view
        Columns("A:A").Interior.ColorIndex = 0

    End With

    Application.ScreenUpdating = True
End Sub

Sub AdjustColorIntensity(currentCellValue As Variant, maximumCellValue As Variant, ByRef r As Integer, ByRef g As Integer, ByRef b As Integer)
    ' Start with base color (pure red: RGB(255, 0, 0))
    Dim intensityFactor As Double
    Dim scaleFactor As Double
    Dim minBigResourceValue As Integer
    Dim maxBigResourceValue As Integer
    Dim minResultValue As Double
    Dim ResultValue As Double
    If currentCellValue < 68 Then 
      r = 255
      g = 192
      b = 192
      Exit Sub
    End If
    ' Apply the coloring but to values bigger than 112, which tend to represent multiple resources because they are summed up
    minBigResourceValue = 112
    If currentCellValue > minBigResourceValue Then 
      r = 255
      g = 0
      b = 255
      maxBigResourceValue = maximumCellValue
      minResultValue = 0.33
      maxResultValue = 1
      intensityFactor = minResultValue + ((currentCellValue - minBigResourceValue) * (maxResultValue - minResultValue)) / (maxBigResourceValue - minBigResourceValue)
      ' Apply the intensity factor to the red component to make the color more red as value increases
      ' For the green and blue components, we'll increase their intensity as currentCellValue increases
      r = r - (255 - r) * (1 - intensityFactor) ' As value increases, make red stronger
      g = g + (255 - g) * (1 - intensityFactor)   ' Add green (white component) as value increases
      b = b + (255 - b) * (1 - intensityFactor)   ' Add blue (white component) as value increases

      ' Ensure RGB values stay within the valid range (0-255)
      r = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, r))
      g = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, g))
      b = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, b))
      Exit Sub
    End If
    
    ' If none of the 2 ifs are hit, then apply coloring to normal resources between 68 and 111, which are normally mean only 1 interaction with the resource
    ' Base color values: Pure red (no green, no blue)
    r = 255
    g = 0
    b = 0
    ' Make sure maximumCellValue is at least 100 because that is enough
    If maximumCellValue > 100 Then
        maximumCellValue = 100
    End If
    
    ' Calculate the intensity factor based on currentCellValue and maximumCellValue
    minBigResourceValue = 68
    maxBigResourceValue = maximumCellValue
    minResultValue = 0.38
    maxResultValue = 1
    intensityFactor = minResultValue + ((currentCellValue - minBigResourceValue) * (maxResultValue - minResultValue)) / (maxBigResourceValue - minBigResourceValue)
    ' intensityFactor = (17/7)*(currentCellValue / maximumCellValue) - (9/7)
    
    ' Apply the intensity factor to the red component to make the color more red as value increases
    ' For the green and blue components, we'll increase their intensity as currentCellValue increases
    r = r - (255 - r) * (1 - intensityFactor) ' As value increases, make red stronger
    g = g + (255 - g) * (1 - intensityFactor)   ' Add green (white component) as value increases
    b = b + (255 - b) * (1 - intensityFactor)   ' Add blue (white component) as value increases

    ' Ensure RGB values stay within the valid range (0-255)
    r = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, r))
    g = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, g))
    b = Application.WorksheetFunction.Min(255, Application.WorksheetFunction.Max(0, b))
End Sub
