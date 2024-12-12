' Declare the colorDict as a global variable at the module level
Dim colorDict As Object
' This function works by needing to have an undeited and unmodified pivot table that will be the same as the one this script will be modifying, thus having 2 pivot tables in different sheets, and the other sheet called "optimizedPivotTable" has the untouched pivot table so that we can remove the current pivot table because this script will leave a lot of uncleanable trash to the PIVOT TABLE object(and not the worksheet this is in), and this way we will have an optimized pivot table that wont be slowed down icreasingly
Sub ClearFormatsExceptPivot()
    Dim ws As Worksheet
    Dim pvt As PivotTable
    Dim cell As Range

    ' Check if there is at least one PivotTable in the active sheet
    If ActiveSheet.PivotTables.Count > 0 Then
        ' Get the first (and only) PivotTable
        Set pvt = ActiveSheet.PivotTables(1)
    End If
    ' //===========================  Saving the pivot table before clear format
    With ActiveSheet
        ' Cells.ClearFormats
        On Error Resume Next
        ' Check if there is a backup pivot in the sheet
        Dim pivotCell As Range
        Dim pvtRange As Range
        Set pivotCell = targetCell.pivotCell
        ' If there is nothing in there, then create the backup
        ' If pivotCell Is Nothing Then
        '     pvt.TableRange2.Copy .Range("CCC999") 'copy to another area within same sheet
        '     Set pvt = ActiveSheet.PivotTables(2)
        ' End If
        ' Deleting the modified PivotTable completely
        ' Set pvtRange = pvt.TableRange2
        ' pvtRange.EntireColumn.Delete
        ' pvt.TableRange2.Worksheet.PivotTables(pvt.Name).TableRange2.Clear
        Cells.Clear
        ' Get the format that was just erased from another sheet that just contains the format for the pivot table
        Set pvt = Sheets("optimizedPivotTable").PivotTables(1)
        pvt.TableRange2.Copy .Range("A1") 'copy to another area within same sheet
        ' Sheets("optimizedPivotTable").Cells.Copy
        
        ' Set pvt = ActiveSheet.PivotTables(1)
        ' pvt.TableRange2.Copy .Range("A1")
        ' pvt.TableRange2.Copy .Range("CCC999") 'copy to another area within same sheet
        ' Set pvt = ActiveSheet.PivotTables(3)
        ' pvt.TableRange2.Worksheet.PivotTables(pvt.Name).TableRange2.Clear
        On Error GoTo 0 ' Reset error handling to default
    End With

End Sub

' Function to highlight the entire columns of non blank cells from the active row, you must select at least 2 cells to enable this
Private Sub Worksheet_SelectionChange(ByVal Target As Range)
    ' If the selected cells is only one, then exit
    If Target.Cells.Count = 1 Then Exit Sub
    ' This simulates a cell that contains 'Row Labels' as a button to refresh the entire pivot table
    If Selection.Count = 2 Then
        ' Check if either of the cells contains the string "Row"
        If InStr(1, Selection.Cells(1, 1).Value, "Row Labels", vbTextCompare) > 0 Or _
           InStr(1, Selection.Cells(2, 1).Value, "Row Labels", vbTextCompare) > 0 Then
            Range("A1").Select
            Call ClearFormatsExceptPivot
        End If
    End If
    ' If too much was selected, then exit
    If Target.Cells.Count > 4 Then Exit Sub
    Application.EnableEvents = False

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
    'Clear the present and probably generated in the sheet
    For Each shp In ActiveSheet.Shapes
        If shp.Type = msoTextBox Then
            shp.Delete
        End If
    Next shp
    
    ' //===========================  Testing to see pivot table fields and know which field has the  'KinfOfDefinition' values

    Dim pt As PivotTable
    Dim kindOfResourceValue As Variant
    Dim pi As PivotItem
    ' Check if there is at least one PivotTable in the active sheet
    If ActiveSheet.PivotTables.Count > 0 Then
        ' Get the first (and only) PivotTable
        Set pt = ActiveSheet.PivotTables(1)
        ' Now you can work with the PivotTable
        Debug.Print pt.Name
    Else
        MsgBox "No PivotTable found in the active worksheet."
    End If

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
        Dim thisCell As Range
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
                ' //=====  Debugging

                ' kindOfResourceValue = pt.GetPivotData("KindOfDefinition", cell.Row, cell.Column)
                ' Debug.Print kindOfResourceValue
                ' //=====  Debugging

                currentCellValue = cell.Value
                maximumCellValue = Application.WorksheetFunction.Max(myRng)
                  If currentCellValue > 112 Then
                      Call AdjustColorIntensity(currentCellValue, maximumCellValue, r, g, b)
                  ' Check if the value is already in the dictionary
                  ElseIf Not colorDict.exists(currentCellValue) Then
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

                ' Highlight the cells according to the corresponding kinfOfDefinition if applicable
                If Target.Cells.Count = 3 Then
                    Set thisCell = cell
                    Call LookupValueInNamedTable(thisCell)
                End If
            End If
        Next cell

        ' Clear or reset the background color in Column A, for the cases where it was colored and has an annoying view
        Columns("A:A").Interior.ColorIndex = 0
        Call FormatColumnBasedOnCriteriaInCurrentCell(myRng)

    End With
    Set pvtCell = Nothing
    Set pt = Nothing
    Set pi = Nothing

    Dim textCell As Range
    Set textCell = Range("CCC1") ' Modify this to the textCell you want to target
    
    ' Increase the textCell's value by 1
    textCell.Value = textCell.Value + 1

    Application.ScreenUpdating = True
    Application.EnableEvents = True
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
    g = 50
    b = 0
    maximumCellValue = 97
    
    ' Calculate the intensity factor based on currentCellValue and maximumCellValue
    minBigResourceValue = 73
    maxBigResourceValue = maximumCellValue
    minResultValue = 0.38
    ' minResultValue = 0.38
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

' This function will put a line in the whole column located at the cell with a value of granularity higher than the granularity level of the primary resource, which interacts with the second resource, as a way to mark the line where this resource is interacting with the resources with lower granularity level than him, or if it is interacting with resources with a higher level of granularity than them
Sub FormatColumnBasedOnCriteriaInCurrentCell(myRng As Range)
    Dim ws As Worksheet
    Set ws = ActiveSheet
    Dim cell As Range
    Dim rng As Range
    Set cell = myRng.Cells(1, 1)
    ' We will only draw the line only if the current active, is positioned in the same row as the granularity value(which is a number)
    If Not IsNumeric(cell.Value) Then Exit Sub

    ' Remove the previous formatting of the border applied
    Set rng = ws.Cells
    rng.Borders.LineStyle = xlNone

    Dim colNum As Long
    Dim maxVal As Double
    Dim targetCol As Long
    Dim i As Long
    ' Loop through each cell in row 2 to get the cell in that row that has a higher granularity value than the one in the current cell
    For i = 1 To ws.Cells(2, ws.Columns.Count).End(xlToLeft).Column
        If IsNumeric(ws.Cells(2, i).Value) Then
            If ws.Cells(2, i).Value > cell.Value Then
                ' ws.Columns(xlEdgeLeft).LineStyle = xlNone
                maxVal = ws.Cells(2, i).Value
                targetCol = i
                Exit For
            End If
        End If
    Next i

    ' Format the column if a valid target column is found
    If targetCol > 0 Then
        ws.Columns(targetCol).Borders(xlEdgeLeft).LineStyle = xlContinuous
        ws.Columns(targetCol).Borders(xlEdgeLeft).Weight = xlThick
    End If


End Sub

' To get the 'Splunk event' from '[Viewpoints_Statements].[SecondaryResource].&[Splunk event]'
Function ExtractTextAfterAmpersand(inputString As String) As String
    Dim startPos As Long
    Dim endPos As Long
    
    ' Find the position of the ampersand
    startPos = InStr(inputString, "&") + 1
    
    ' Check if ampersand was found
    If startPos = 0 Then
        ExtractTextAfterAmpersand = "Ampersand not found"
        Exit Function
    End If
    
    ' Find the position of the opening bracket after the ampersand
    startPos = InStr(startPos, inputString, "[")
    
    ' Check if opening bracket was found
    If startPos = 0 Then
        ExtractTextAfterAmpersand = "Opening bracket not found"
        Exit Function
    End If
    
    ' Find the position of the closing bracket for the first bracketed text
    endPos = InStr(startPos + 1, inputString, "]")
    
    ' Check if closing bracket was found
    If endPos = 0 Then
        ExtractTextAfterAmpersand = "Closing bracket not found"
        Exit Function
    End If
    
    ' Extract the text inside the brackets
    ExtractTextAfterAmpersand = Mid(inputString, startPos + 1, endPos - startPos - 1)
End Function

Sub LookupValueInNamedTable(cell As Range)
    Dim ws As Worksheet
    Dim table As ListObject
    Dim colIndex As Integer
    Dim kindOfDefinitionString As Variant
    Dim foundRow As Range

    Dim pvtCell As pivotCell
    Dim pvtField As PivotField
    Dim pvtItem As PivotItem
    Dim primaryResourceName As Variant
    Dim secondaryResourceName As Variant
    Dim lookupString As Variant
    Set pvtCell = cell.pivotCell
    Dim colors(0 To 19) As Long ' Declare as an array of Long with a fixed size
    Dim colorValue As Long
    Dim firstAddress As String
    Dim loopCounter As Integer

    ' Initialize the array of 20 distinct colors
    colors(0) = RGB(255, 69, 0)     ' Red Orange
    colors(1) = RGB(0, 255, 0)      ' Green
    colors(2) = RGB(255, 20, 147)   ' Deep Pink
    colors(3) = RGB(255, 255, 0)    ' Yellow
    colors(4) = RGB(255, 165, 0)    ' Orange
    colors(5) = RGB(173, 216, 230)  ' Light Blue
    colors(6) = RGB(0, 255, 255)    ' Cyan
    colors(7) = RGB(255, 192, 203)  ' Pink
    colors(8) = RGB(255, 0, 0)      ' Red
    colors(9) = RGB(139, 235, 117)      '  Dark Blue
    colors(10) = RGB(255, 105, 180)  ' Hot Pink
    colors(11) = RGB(128, 128, 0)    ' Olive
    colors(12) = RGB(240, 230, 140)  ' Khaki
    colors(13) = RGB(255, 228, 196)  ' Bisque
    colors(14) = RGB(0, 100, 0)      ' Dark Green
    colors(15) = RGB(0, 128, 128)    ' Teal
    colors(16) = RGB(204, 137, 255)    ' Indigo
    colors(17) = RGB(210, 105, 30)   ' Chocolate
    colors(18) = RGB(189, 189, 255)      ' Blue
    colors(19) = RGB(128, 0, 128)    ' Purple

    Dim i As Integer
    Dim charCode As Long

    ' Getting the values to lookup the kind of definition
    ' viewpointName = ExtractTextAfterAmpersand(pvtCell.RowItems(1))
    ' primaryResourceName = ExtractTextAfterAmpersand(pvtCell.RowItems(3))
    ' secondaryResourceName = ExtractTextAfterAmpersand(pvtCell.ColumnItems(2))
    viewpointName = pvtCell.RowItems(1)
    primaryResourceName = pvtCell.RowItems(3)
    secondaryResourceName = pvtCell.ColumnItems(2)
    lookupString = viewpointName & primaryResourceName & secondaryResourceName

    ' Set your worksheet
    Set ws = ThisWorkbook.Sheets("Viewpoints_Statements") ' Change to your sheet name

    ' Get the named table by its name
    Set table = ws.ListObjects("Viewpoints_Statements") ' Change to your table name

    ' Specify the column index from which you want to retrieve the value (e.g., 2 for the second column)
    colIndex = 6 ' Change to the desired column index

    ' Search for the lookup value in the first column of the table
    Set foundRow = table.ListColumns(8).DataBodyRange.Find(lookupString, LookIn:=xlValues, LookAt:=xlWhole)
    loopCounter = -1

    ' Check if the value was found
    If Not foundRow Is Nothing Then
        firstAddress = foundRow.Address
        ' loop until we wrap back to the first found cell
        Do
            loopCounter = loopCounter + 1
            ' Retrieve the value from the specified column index
            kindOfDefinitionString = foundRow.Offset(0, -2).Value

            '//===========================  Get the value transforming the string into a integer below the size of the colors array
            colorValue = 0
            ' Loop through each character in the string
            For i = 1 To Len(kindOfDefinitionString)
                ' Get the ASCII code of the character
                charCode = Asc(Mid(kindOfDefinitionString, i, 1))
                ' Update the hash value (a simple hash function)
                colorValue = (colorValue * 31 + charCode) Mod UBound(colors)
            Next i
            '//===========================

            ' Add a text box over the cell
            Dim txtBox As Shape
            Dim cellValue As Integer
            cellValue = cell.Value
            Set ws = ActiveSheet ' Adjust the sheet name as needed
            Set cell = cell.Offset(-1, 0)
            Set txtBox = ws.Shapes.AddTextbox(msoTextOrientationHorizontal, cell.Left, cell.Top-29*loopCounter, cell.Width, cell.Height)

            ' Set the text box properties
            With txtBox
                .TextFrame.Characters.Text = kindOfDefinitionString
                .TextFrame.HorizontalAlignment = xlHAlignLeft
                .TextFrame.VerticalAlignment = xlVAlignCenter
                .Line.Visible = msoFalse
                .Rotation = -90 ' Rotate the text box to 46 degrees
                ' .TextFrame.AutoSize = True
                .Width = txtBox.Width + 28 ' Increase the width by 50 points (adjust as needed)
                ' .Fill.Visible = msoFalse ' Make the background transparent
                .Fill.ForeColor.RGB = colors(colorValue) ' Example: Yellow background (RGB value)
                .TextFrame.Characters.Font.Size = 10 ' Example font size, adjust as needed
                .TextFrame.Characters.Font.Bold = True ' Makes the text bold
            End With
            
            ' Find the next occurrence
            Set foundRow = table.ListColumns(8).DataBodyRange.Find(lookupString, LookIn:=xlValues, LookAt:=xlWhole, After:=foundRow)
        Loop While Not foundRow Is Nothing And foundRow.Address <> firstAddress    
    End If
    Set pvtCell = Nothing
    Set pvtField = Nothing
    Set pvtItem = Nothing
End Sub





