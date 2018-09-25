<!--#include file="function.asp" -->
<!--#include file="template.asp" -->
<% call CheckSession()%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Welcome to Modern Hospital.</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    <script src="customjs.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>
    <%
    dim query
    Dim objConn, objRS, sqlString
    set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    
    set objRS = Server.CreateObject("ADODB.Recordset")
    sqlString ="select * from Test"
    objRS.Open sqlString, objConn
   
%>
            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th>Test Name</th>
                    <th>Test Type</th>
                    <th>Unit Price</th>
                    <th>Date</th>
                    <th></th>
                </thead>
                <% Do Until objRs.EOF = True%>

                <tr id="<%=objRS("iD")%>">
                    <td>
                        <%Response.Write(objRS("TestName"))%>
                    </td>
                    <td>
                        <%Response.Write(objRS("Type"))%>
                    </td>
                    <td>
                        <%Response.Write(objRS("UnitPrice"))%>
                    </td>
                    <td>
                        <%Response.Write(objRS("AddingDate"))%>
                    </td>

                    <td> <a href='editTest.asp?Id=<%=objRS("Id")%>'>Edit</a></td>
                </tr>
                <%
			    objRS.MoveNext
                loop
                objRS.Close
                 objConn.Close
			
			%>
            </table>
</body>

</html>