<!--#include file="template.asp" -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Welcome to Modern Hospital.</title>

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

<%
     If Request.form("hidden") = "1" Then
         set conn=Server.CreateObject("ADODB.Connection")
         conn.Provider="Microsoft.Jet.OLEDB.4.0"
         conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
         
         email= Request.Form("email") 
         password= Request.Form("password") 

         If email = "" Then
             emailError = "Email is Required."
         ElseIf password = "" Then
             passwordError = "Password is Required."                
         else                
             set rs=Server.CreateObject("ADODB.recordset")
             rs.Open "Select * FROM Admin Where Email='"&email&"' AND Password='"&password&"'", conn

            if not rs.EOF then
                Session("username")= rs("Email")
                Session("password")= rs("Password")
                Response.redirect "index.asp"
             Else
                errorMessage="Email Or Password is Invalid !"
             End If
             conn.close
         End if
     End If
%>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6 mx-auto" style="margin-top:20%">
                    <div class="card">
                        <div class="card-header bg-primary text-center">
                            <h2>Login Here</h2>
                        </div>
                        <div class="card-body">
                            <form action="login.asp" method="POST">
                                <label class="text-danger" for=""><%=errorMessage%></label>
                                <div class="form-group">
                                    <input type="hidden" value="1" id="hidden" name="hidden">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" value="<%=email%>" name="email" id="email" placeholder="Enter email">
                                    <label class="text-danger" for=""><%=emailError%></label>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" value="<%=password%>" name="password" id="password" placeholder="Enter Password">
                                    <label class="text-danger" for=""><%=passwordError%></label>
                                </div>
                                <div class="text-center">
                                    <button class="btn-block btn-primary" type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>

</html>