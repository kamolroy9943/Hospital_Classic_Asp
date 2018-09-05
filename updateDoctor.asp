<!--#include file="template.asp" -->
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
            <div class="col-md-6 mx-auto ">
              <%
                    set conn=Server.CreateObject("ADODB.Connection")
                    conn.Provider="Microsoft.Jet.OLEDB.4.0"
                    conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

                  
                   hiddenId= request.form("hidden")

                   doctorName= Request.Form("doctorName") 
                   email= Request.Form("Email")
                   phone= Request.Form("phoneNo") 
                   specialization= Request.Form("Specialization") 
                   <!-- sql="INSERT INTO Patient (PatientName,Age,Phone,Address) VALUES ('"&patientName&"',"&age&",'"&phone&"','"&address&"')" -->
                   sql="Update Doctor SET Name ='"&doctorName&"', Email='"&email&"', PhoneNo= '"&phone&"', Specialization='"&specialization&"' Where Id="&hiddenId&""
                   conn.Execute sql,recaffected
                   Response.Write("<h3 class='text-center text-success'>" & recaffected & " Record Added Successfull !</h3>")
                   conn.close
                   Response.Redirect "doctorList.asp"
                %>
            </div>
        </div>
    </div>

</body>

</html>






 