<%
    id= Request.QueryString("data")                            
    set conn=Server.CreateObject("ADODB.Connection")
    conn.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("hospital.mdb")
    set rs=Server.CreateObject("ADODB.recordset")
    sql = "Delete FROM Patient Where Id IN("&id&")"
    conn.Execute sql,recaffected
    conn.Close 
%>