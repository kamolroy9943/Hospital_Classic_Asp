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
    <%
        If Request.form("hidden") = "1" Then
            set conn=Server.CreateObject("ADODB.Connection")
            conn.open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= "& Server.MapPath("hospital.mdb")

            patientName= Request.Form("patientName") 
            age = Request.Form("age")
            phone= Request.Form("phoneNo") 
            address= Request.Form("address") 
        
       
            If isnull(age) = true OR age= "" Then
                ageError = "Age is Required." 
            Else
                If  age = 0 Then
                    ageError = "Age should be greater than 0"
                End If
            End If 
                       
            If patientName = "" Then
                    patientError = "Test Name is Required."             
                ElseIf phone = "" Then 
                    phoneError="Contact no is Required."
                ElseIf address = "" Then 
                    addressError="Address is Required."
                else   
                    <!-- sql="INSERT INTO Patient (PatientName,Age,Phone,Address) VALUES ('"&patientName&"',"&age&",'"&phone&"','"&address&"')" -->
                    sql="INSERT INTO Patient (Name,Age,Phone,Address) VALUES ('"&patientName&"',"&age&",'"&phone&"','"&address&"')"
                    conn.Execute sql,recaffected
                    Response.Write("<h3 class='text-center text-success'>" & recaffected & " Record Added Successfull !</h3>")
                    conn.close
                    Response.Redirect "patientList.asp"
            End If
       End If
   %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 mx-auto ">
                    <div class="card">
                        <div class="card-header bg-primary test-upercase">ADD PATIENT HERE</div>
                        <hr>
                        <div class="card-body">
                            <form action="addPatientForm.asp" method="POST">
                                <div class="form-group">
                                    <input type="hidden" value="1" id="hidden" name="hidden">
                                </div>
                                <div class="form-group">
                                    <label for="patientName">Patient Name:</label>
                                    <input type="text" class="form-control" value="<%=patientName%>" id="patientName" name="patientName" placeholder="Enter Patient Name.">
                                    <label for="patientName" class="text-danger" name="patientNameErrorMsg" id="patientNameErrorMsg"><%=patientError%></label>
                                </div>
                                <div class="form-group">
                                    <label for="age">Age:</label>
                                    <input type="number" class="form-control" value="<%=age%>" id="age" name="age" placeholder="Enter Patient Age.">
                                    <label for="age" class="text-danger" name="ageErrorMsg" id="ageErrorMsg"><%=ageError%></label>
                                </div>
                                <div class="form-group">
                                    <label for="phoneNo">Contact No:</label>
                                    <input type="number" class="form-control" value="<%=phone%>" id="phoneNo" name="phoneNo" placeholder="Enter Patient Phone">
                                    <label for="phoneNo" class="text-danger" name="phoneNoErrorMsg" id="phoneNoErrorMsg"><%=phoneError%></label>
                                </div>
                                <div class="form-group">
                                    <label for="address">Address:</label>
                                    <input type="text" class="form-control" value="<%=address%>" id="address" name="address" placeholder="Enter Patient Address">
                                    <label for="address" class="text-danger" name="addressErrorMsg" id="addressErrorMsg"><%=addressError%></label>
                                </div>
                                <div class="inline">
                                    <button type="submit" onclick="return CheckValidation()" name="submitButton" id="submitButton" class="btn btn-success">Submit</button>
                                    <!-- <a href="testList.asp" class="btn btn-info">View Test List</a> -->
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script>  
            function CheckValidation() {
                var patientName = document.getElementById("patientName").value;
                var age = document.getElementById("age").value;
                var phone = document.getElementById("phoneNo").value;
                var address = document.getElementById("address").value;

                if (patientName == null || patientName == "") {
                    document.getElementById("patientNameErrorMsg").innerHTML = "Please fill up the patientName";
                    return false;
                } else {
                    document.getElementById("patientNameErrorMsg").innerHTML = "";
                }

                if (age == null || age == "") {
                    document.getElementById("ageErrorMsg").innerHTML = "Please fill up the Age";
                    return false;
                } else {
                    if (age <= 0) {
                        document.getElementById("ageErrorMsg").innerHTML = "Age Should be greater than 0.";
                        return false;
                    } else {
                        document.getElementById("ageErrorMsg").innerHTML = "";
                    }
                }
                if (phone == null || phone == "") {
                    document.getElementById("phoneNoErrorMsg").innerHTML = "Please fill up the Phone Number";
                    return false;
                } else {
                    document.getElementById("phoneNoErrorMsg").innerHTML = "";
                }
                if (address == null || address == "") {
                    document.getElementById("addressErrorMsg").innerHTML = "Please fill up the Address";
                    return false;
                } else {
                    document.getElementById("addressErrorMsg").innerHTML = "";
                }
            }
        </script>
</body>

</html>
