Public Function checkBios()
    badBios = False
    Dim badBiosNames({{badbios|length - 1}}) As String
    {% for bios in badbios %}badBiosNames({{loop.index0}}) = "{{bios}}"
    {% endfor %}

    Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
    Set colItems = objWMIService.ExecQuery("Select * from Win32_Bios", , 48)

    For Each objItem In colItems

        For Each badName In badBiosNames
            If InStr(LCase(objItem.SMBIOSBIOSVersion), badName) > 0 Then
                badBios = True
            End If
            If InStr(LCase(objItem.SerialNumber), badName) > 0 Then
                badBios = True
            End If
        Next

    Next

    If badBios Then
        checkBios = True
    Else
        checkBios = False
    End If

End Function
