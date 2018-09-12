<%
    id= Request.QueryString("data")                            
    set conn=Server.CreateObject("ADODB.Connection")
    conn.Provider="Microsoft.Jet.OLEDB.4.0"
    conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

    set rs=Server.CreateObject("ADODB.recordset")
    sql = "Delete FROM Test Where Id IN("&id&")"
    conn.Execute sql,recaffected
    conn.Close 
%>