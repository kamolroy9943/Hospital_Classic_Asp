<%
Dim testError,typeError,priceError
If Request.form("hidden") = "1" Then
    set conn=Server.CreateObject("ADODB.Connection")
    conn.open "Provider= Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")
    
    testName= Request.Form("testName") 
    testType= Request.Form("testType") 
    unitPrice= Request.Form("unitPrice") 
    dte= Request.Form("date") 

    If testName = "" Then
        testError = "Test Name is Required."
    ElseIf testType = "" Then
        typeError = "Test Name is Required."                
    ElseIf unitPrice = "" Then 
        priceError="Unit Price is Required."
    else                
        sql="INSERT INTO Test (TestName,Type,UnitPrice,AddingDate) VALUES ('"&testName&"','"&testType&"',"&unitPrice&",'"&dte&"')"
        Response.write sql
        conn.Execute sql,recaffected
        conn.close
    End if
End If
%>