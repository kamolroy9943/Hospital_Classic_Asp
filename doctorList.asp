<!--#include file="template.asp" -->
<!--#include file="function.asp" -->
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
</head>

<body>

    <div>
        <% call Template %>
    </div>

    <div class="container">
        <div class="row">
        
                <table class="table table-border table-hover table-striped">
                    <thead class="thead-dark">
                        <th>Doctor Name</th>
                        <th>Email</th>
                        <th>Phone No</th>
                        <th>Specialization</th>
                        <th></th>
                        <th></th>
                    </thead>
                    <%
                            set conn=Server.CreateObject("ADODB.Connection")
                            conn.Provider="Microsoft.Jet.OLEDB.4.0"
                            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
                    
                            set rs=Server.CreateObject("ADODB.recordset")
                            rs.Open "Select * FROM Doctor", conn
                    
                            Do While Not rs.EOF
                                    id=rs("Id")
                                    response.write "<tr><td>" & rs("Name") & "</td>"
                                    response.write "<td>" & rs("Email") & "</td>"
                                    response.write "<td>" & rs("PhoneNo") & "</td>"
                                    response.write "<td>" & rs("Specialization") & "</td>"
                                    response.write "<td><a href='editDoctor.asp?Id="&id&"'>Edit</a></td>"
                                    response.write "<td><a onclick=' return deleteConfirm()' href='deleteDoctor.asp?Id="&id&"'>Delete</a></td></tr>"
                            rs.MoveNext
                            Loop
                            rs.Close
                            conn.Close                   
                       %>
                </table>
             
        </div>
    </div>


   
    <script>
        function deleteConfirm() {
            return confirm('Do you really want to delete this location?');  
        }
    </script>
</body>

</html>