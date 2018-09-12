<%
Sub CheckSession()
    cookie = Request.Cookies("id")

    if session("email")="" Then 
       if Cstr(cookie) = ""   Then
            response.redirect "login.asp"
        Else 
            set conn=Server.CreateObject("ADODB.Connection")
            conn.Provider="Microsoft.Jet.OLEDB.4.0"
            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

            set rs=Server.CreateObject("ADODB.recordset")
            rs.Open "Select * FROM Admin Where ID = "&cookie&"", conn
            if not rs.EOF then
                session("email")=rs("Email")
            End If
        End If
    End If
End Sub




 

 Function getFileName(lsPath)

  lsPath = Request.ServerVariables("SCRIPT_NAME")

  arPath = Split(lsPath, "/")

  GetFileName =arPath(UBound(arPath,1))

  End Function

 
%>  
