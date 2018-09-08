<%
    set conn=Server.CreateObject("ADODB.Connection")
    conn.Provider="Microsoft.Jet.OLEDB.4.0"
    conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

    set rs=Server.CreateObject("ADODB.recordset")
    rs.Open "Select * FROM Test", conn

    
do while not rs.eof %>
<option value="<%= rs.Fields(0) %>" ><%= rs.Fields(1) %></option>
<% rs.MoveNext
Loop
conn.close
set conn = nothing %>