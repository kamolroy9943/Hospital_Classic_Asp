<!--#include file="template.asp" -->
<!--#include file="function.asp" -->
<% call CheckSession%>
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
        <%
            If Request.form("hidden") = "1" Then
                set conn=Server.CreateObject("ADODB.Connection")
                conn.open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= "& Server.MapPath("hospital.mdb")
                
                doctorName= Request.Form("doctorName") 
                email= Request.Form("email") 
                phoneNo= Request.Form("phoneNo") 
                designation= Request.Form("designation") 

                If doctorName = "" Then
                    doctorNameError = "Doctor Name is Required."
                    ElseIf email = "" Then
                    emailError = "Email is Required."                
                    ElseIf phoneNo = "" Then 
                    phoneError="Contact No is Required."
                    ElseIf designation = "" Then 
                    designationError="Designation is Required."
                else  
                    sql="INSERT INTO Doctor (Name,Email,PhoneNo,Specialization) VALUES ('"&doctorName&"','"&email&"',"&phoneNo&",'"&designation&"')"
                    conn.Execute sql,recaffected
                    Response.Write("<h3 class='text-center text-success'>" & recaffected & " record added</h3>")
                    conn.close
                    Response.Redirect "doctorList.asp"
                End If
            End If
        %>
            <div class="container">
                <div class="row">
                    <div class="col-md-6 mx-auto ">
                        <div class="card">
                            <div class="card-header bg-primary test-upercase">ADD Doctor HERE</div>
                            <hr>
                            <div class="card-body">
                                <form action="addDoctorFrom.asp" method="POST">
                                    <div class="form-group">
                                        <input type="hidden" value="1" id="hidden" name="hidden">
                                    </div>
                                    <div class="form-group">
                                        <label for="doctorName">Doctor Name:</label>
                                        <input type="text" class="form-control" value="<%=doctorName%>" id="doctorName" name="doctorName" placeholder="Enter Doctor Name.">
                                        <label class="text-danger" for="doctorName"><%=doctorNameError%></label>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email:</label>
                                        <input type="email" class="form-control" value="<%=email%>" id="email" name="email" placeholder="Enter Doctor Email.">
                                        <label class="text-danger" for="email"><%=emailError%></label>
                                    </div>
                                    <div class="form-group">
                                        <label for="phoneNo">Contact No:</label>
                                        <input type="number" class="form-control" value="<%=phone%>" id="phoneNo" name="phoneNo" placeholder="Enter Doctor Phone">
                                        <label class="text-danger" for="phoneNo"><%=phoneError%></label>
                                    </div>
                                    <div class="form-group">
                                        <label for="desingation">Designation:</label>
                                        <input type="textarea" class="form-control" value="<%=desingation%>" id="designation" name="designation" placeholder="Enter Doctor Designation">
                                        <label class="text-danger" for="designation"><%=designationError%></label>
                                    </div>
                                    <div class="inline">
                                        <button type="submit" class="btn btn-success">Submit</button>
                                        <a href="doctorList.asp" class="btn btn-info">View Doctor List</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </body>

    </html>