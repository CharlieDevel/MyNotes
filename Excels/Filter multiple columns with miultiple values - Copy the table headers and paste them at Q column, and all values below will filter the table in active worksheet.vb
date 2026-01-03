
' This should be inserted as a macro, you do this by pressing Alt + f11 > Insert > Module, and paste all in here, to activate the macro, you can press Alt + f8, and select the 'FilterQueryTable' macro
' The way this works is simple, this will detect the first table it detects in the active worksheet, then it will map the columns in the table to the columns in the "wsForFiltering" sheet, which is just a 'logical table': The way it works is basically by making each column in this sheet correspond to the columns in the table(that is why we should copy the headers of the table and paste them in the first row of this sheet, because the algorithm automatically thinks that each columns is mapped to the table in a logical way, and we write the headers to help us know which column in this worksheet is mapped to which column in the table, the algorithm actually ignores the first column), and whatever values are in each of the columns in the 'wsForFiltering' sheet are going to be the values to filter(it is an exact match)
' We can filter by multiple values in a column by writing multiple rows in the column we desire, and we can do the same for any of the columns here
Sub FilterQueryTable()

    Dim ws As Worksheet
    Dim wsForFiltering As Worksheet
    Dim tbl As ListObject
    Dim tblCol As ListColumn
    Dim filterCol As Range
    Dim filterValues() As String
    Dim lastRow As Long
    Dim i As Long
    Dim filterIndex As Long
    
    Set ws = ActiveSheet
    Set wsForFiltering = ThisWorkbook.Worksheets("wsForFiltering")
    Set tbl = ws.ListObjects(1)   ' There is always exactly 1 table
    
    ' Clear existing filters
    'If tbl.AutoFilter.FilterMode Then
    '    tbl.AutoFilter.ShowAllData
    'End If
    
    ' Loop through each column in the table
    For filterIndex = 1 To tbl.ListColumns.Count
        
        ' Filter values are in the 1st column onwards, you have to place the headers on the first row and first column...
        Set filterCol = wsForFiltering.Cells(1, 1 + filterIndex - 1).EntireColumn
        
        ' Find last used row in the filter column
        lastRow = wsForFiltering.Cells(ws.Rows.Count, filterCol.Column).End(xlUp).Row
        
        ' Skip header-only columns (no filter values)
        If lastRow <= 1 Then GoTo NextColumn
        
        ' Build filter values array (excluding header)
        ReDim filterValues(1 To lastRow - 1)
        
        For i = 2 To lastRow
            filterValues(i - 1) = wsForFiltering.Cells(i, filterCol.Column).Value
        Next i
        
        ' Apply the filter (OR logic by default)
        tbl.Range.AutoFilter _
            Field:=filterIndex, _
            Criteria1:=filterValues, _
            Operator:=xlFilterValues
        
NextColumn:
    Next filterIndex

End Sub


