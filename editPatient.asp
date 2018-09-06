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
            <%
               Dim patientName,age,contactNo,address

                id=Request.QueryString("Id")
                                
                set conn=Server.CreateObject("ADODB.Connection")
                conn.Provider="Microsoft.Jet.OLEDB.4.0"
                conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
        
                set rs=Server.CreateObject("ADODB.recordset")
                rs.Open "Select * FROM Patient Where Id= "&id&"", conn

                patientName= rs("Name")
                age =rs("Age")
                contactNo= rs("Phone")
                address = rs("Address")

                rs.Close
                conn.Close 
           %>

                <div class="col-md-6 mx-auto ">
                    <div class="card">
                        <div class="card-header bg-primary test-upercase">ADD PATIENT HERE</div>
                        <hr>
                        <div class="card-body">
                            <form action="updatePatient.asp" method="POST">
                                <div class="form-group">
                                    <input type="hidden" value="<%=id%>" id="hidden" name="hidden">
                                </div>

                                <div class="form-group">
                                    <label for="patientName">Patient Name:</label>
                                    <input type="text" class="form-control" value="<%=patientName%>" id="patientName" name="patientName" placeholder="Enter Patient Name.">
                                </div>
                                <div class="form-group">
                                    <label for="age">Age:</label>
                                    <input type="number" class="form-control" value="<%=age%>" id="age" name="age" placeholder="Enter Patient Age.">
                                </div>
                                <div class="form-group">
                                    <label for="phoneNo">Contact No:</label>
                                    <input type="number" class="form-control" value="<%=contactNo%>" id="phoneNo" name="phoneNo" placeholder="Enter Patient Phone">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address:</label>
                                    <input type="textarea" class="form-control" value="<%=address%>" id="address" name="address" placeholder="Enter Patient Address">
                                </div>
                                <div class="inline">
                                    <button type="submit" class="btn btn-success">Update</button>
                                    <a href="patientList.asp" class="btn btn-info">Back To List</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
        </div>
    </div>


</body>

</html>