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
        <input type="hidden" id="fileName" value="<%=fileName%>">
    </div>

    <div class="container">
        <div class="row">
            <form class="mt-5 mb-4" align="center" method="POST" action="patientList.asp">
                <div class="row">
                    <div class="col">
                        <strong>Name</strong>
                        <input type="text" class="form-control" name="patientName" placeholder="Enter Name">
                    </div>
                    <div class="col">
                        <strong>Address:</strong>
                        <input type="text" class="form-control" name="address" placeholder="Enter Address">
                    </div>
                    <div class="col inline">
                        <strong>Age From:</strong>
                        <input type="number" class="form-control" name="fromAge" placeholder="Enter From Number">
                    </div>
                    <div class="col">
                        <strong>Age To:</strong>
                        <input type="number" class="form-control" name="toAge" placeholder="Enter To Number">
                    </div>
                    <div class="col">

                        <button class="btn btn-primary mt-4" type="submit">Search</button>
                    </div>
                </div>
            </form>
            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th>Patient Name</th>
                    <th>Age</th>
                    <th>Phone No</th>
                    <th>Address</th>
                    <th></th>
                    <th></th>
                </thead>
                <%
                            set conn=Server.CreateObject("ADODB.Connection")
                            conn.Provider="Microsoft.Jet.OLEDB.4.0"
                            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

                            name = Request.Form("patientName")
                            address= Request.Form("address")
                            fromAge= Request.Form("fromAge")
                            toAge= Request.Form("toAge")
 
                        Dim query

                        if(name<>"" And address <>"" and fromAge <>"" And toAge <>"")Then
                            query ="Select * FROM Patient Where (Name LIKE  '"&name&"%' OR Address LIKE '"&address&"%') AND (Age BETWEEN "&fromAge&" AND "&toAge&")"
                        elseif(name<>"" And address ="" and fromAge ="" And toAge ="")Then
                            query ="Select * FROM Patient Where Name LIKE  '"&name&"%'"
                        elseif(name="" And address <>"" and fromAge ="" And toAge ="")Then 
                            query ="Select * FROM Patient Where Address LIKE  '"&address&"%'"
                        elseif(name="" And address ="" and fromAge <>"" And toAge <>"")Then 
                            query ="Select * FROM Patient Where Age BETWEEN "&fromAge&" AND "&toAge&""
                        else
                        query ="Select * FROM Patient"

                        end if
                            set rs=Server.CreateObject("ADODB.recordset")
                            rs.Open query, conn

                            Do While Not rs.EOF
                                    id=rs("Id")
                                    response.write "<tr><td>" & rs("Name") & "</td>"
                                    response.write "<td>" & rs("Age") & "</td>"
                                    response.write "<td>" & rs("Phone") & "</td>"
                                    response.write "<td>" & rs("Address") & "</td>"
                                    response.write "<td><a href='editPatient.asp?Id="&id&"'>Edit</a></td> "
                                    response.write "<td><a id='deleteButton' onclick='return deleteConfirm()' href='deletePatient.asp?Id="&id&"'>Delete</a></td></tr>"
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

        var value = $("#fileName").val();
        if (value == "patientList.asp") {
            $("#patientList").css('background', 'green');
        }

    </script>
</body>

</html>