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
                rs.Open "Select * FROM Test Where Id= "&id&"", conn

                testName= rs("TestName")
                testType =rs("Type")
                unitPrice= rs("UnitPrice")
                rs.Close
                conn.Close 
           %>
            <div class="col-md-6 mx-auto ">
                <div class="card">
                    <div class="card-header bg-primary test-upercase">ADD PATIENT HERE</div>
                    <hr>
                    <div class="card-body">
                        <form action="updateTest.asp" method="POST">
                            <div class="form-group">
                                <input type="hidden" value="<%=id%>" id="hidden" name="hidden">
                            </div>
                            <div class="form-group">
                                <label for="firstName">Test Name:</label>
                                <input type="text" class="form-control" value="<%=testName%>" id="testName" name="testName"
                                    placeholder="Enter Test Name.">
                            </div>
                            <div class="form-group">
                                <label for="lastName">Test Type:</label>
                                <input type="text" class="form-control" value="<%=testType%>" id="testType" name="testType"
                                    placeholder="Enter Test Type.">
                            </div>
                            <div class="form-group">
                                <label for="lastName">Unit Price:</label>
                                <input type="number" class="form-control" value="<%=unitPrice%>" id="unitPrice" name="unitPrice"
                                    placeholder="Enter your email">
                            </div>
                            <div class="inline">
                                <button type="submit" class="btn btn-success">Submit</button>
                                <a href="testList.asp" class="btn btn-info">View Test List</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>