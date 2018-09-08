<%

id= Request.QueryString("Id")
                                
set conn=Server.CreateObject("ADODB.Connection")
conn.Provider="Microsoft.Jet.OLEDB.4.0"
conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

set rs=Server.CreateObject("ADODB.recordset")
rs.Open "Select UnitPrice FROM Test Where Id = "&id&"", conn
    response.write(rs("UnitPrice"))
    conn.close     
%>