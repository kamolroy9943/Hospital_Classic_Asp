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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>

    <div>
        <% call Template %>
    </div>

    <%
        If Request.form("hidden") = "1" Then
            set conn=Server.CreateObject("ADODB.Connection")
            conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    

            patientId= Request.Form("patientId")
            testId= Request.Form("testId")
            doctorId= Request.Form("doctorId")
            totalAmount= Request.Form("totalAmount")

            sql="INSERT INTO Patient_Test (Patientid,TestId,DoctorId,TotalAmount) VALUES ("&patientId&","&testId&","&doctorId&","&totalAmount&")"
            'response.write(sql)
            conn.Execute sql,recaffected
            Response.Write("<h3 class='text-center text-success'>" & recaffected & " record added</h3>")
            conn.close
        End If
    %>

    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto ">
                <div class="card">
                    <div class="card-header bg-primary text-uppercase">ADD PATIENT TEST HERE</div>
                    <hr>
                    <div class="card-body">
                        <form action="patientTestAddForm.asp" method="POST">
                            <div class="form-group">
                                <input type="hidden" value="1" id="hidden" name="hidden">
                            </div>
                            <div class="form-group">
                                <label for="patientId">Patient:</label>
                                <select class="form-control" name="patientId" id="patientId">
                                    <option value=''>-------Select Patient-------</option>
                                    <%
                                        set conn=Server.CreateObject("ADODB.Connection")
                                        conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    

                                        set rs=Server.CreateObject("ADODB.recordset")
                                        rs.Open "Select * FROM Patient", conn

                                        Do While Not rs.EOF
                                    %>
                                    <option value='<%=rs("Id")%>'>
                                        <%=rs("Name")%>
                                    </option>
                                    <%
                                        rs.movenext
                                        Loop
                                        rs.close
                                    %>
                                </select>
                                <label class="text-danger" for="patientId" id="patientIdErrorMsg" name="patientIdErrorMsg"></label>
                            </div>
                            <div class="form-group">
                                <label for="testId">Test:</label>
                                <select class="form-control" name="testId" id="testId">
                                    <option value=0>------- Select One -------</option>
                                </select>
                                <label class="text-danger" for="testId" id="testIdErrorMsg" name="testIdErrorMsg"></label>
                            </div>
                            <div class="form-group">
                                <label for="doctorId">Refered By:</label>
                                <select class="form-control" name="doctorId" id="doctorId">
                                    <option value=0>-------Select Doctor-------</option>
                                    <%
                                            set conn=Server.CreateObject("ADODB.Connection")
                                            conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    
                                    
                                            set rs=Server.CreateObject("ADODB.recordset")
                                            rs.Open "Select * FROM Doctor", conn
                            
                                            Do While Not rs.EOF
                                                %>
                                    <option value='<%=rs("Id")%>'>
                                        <%=rs("Name")%>
                                    </option>
                                    <%
                                                rs.movenext
                                            Loop
                                            rs.close
                                            %>
                                </select>
                                <label class="text-danger" for="doctorId" id="doctorIdErrorMsg" name="doctorIdErrorMsg"></label>
                            </div>
                            <div class="form-group">
                                <label for="totalAmount">Total Amount:</label>
                                <input type="number" class="form-control" value="<%=value%>" id="totalAmount" name="totalAmount"
                                    placeholder="Enter Test Amount">
                                <label class="text-danger" for="totalAmount" name="totalAmountErrorMsg" id="totalAmountErrorMsg"></label>
                            </div>
                            <div class="inline">
                                <button type="submit" onclick="return CheckFormValidation()" class="btn btn-success">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(function (ready) {
            $("#testId").change(function () {
                var testId = $("#testId").val();
                if (testId == 0) {
                    $('#totalAmount').val(0);
                    return;
                }
                $.ajax({
                    url: 'getPriceByTestId.asp?Id=' + testId,
                    success: function (data) {
                        if (data)
                            $("#totalAmount").val(data);
                    }
                });
            });


            $("#patientId").change(function () {
                var patientId = $("#patientId").val();
                $("#testId").empty();

                if (patientId <= 0) {
                    $("#testId").empty();
                    $("#testId").append('<option value="" >-------- Select One --------</option>')
                } else {
                    $.ajax({
                        url: 'populateTestDropdown.asp',
                        success: function (data) {
                            $("#testId").append(data);
                        }
                    });
                }
            });
        });

        function CheckFormValidation() {
            var patientId = document.getElementById("patientId").value;
            var testId = document.getElementById("testId").value;
            var doctorId = document.getElementById("doctorId").value;
            var totalAmount = document.getElementById("totalAmount").value;

            if (patientId <= 0 || patientId == NaN) {
                document.getElementById("patientIdErrorMsg").innerHTML = "Please Select a Patient";
                return false;
            } else {
                document.getElementById("patientIdErrorMsg").innerHTML = "";
            }

            if (testId <= 0 || testId == NaN) {
                document.getElementById("testIdErrorMsg").innerHTML = "Please Select a Test";
                return false;
            } else {
                document.getElementById("testIdErrorMsg").innerHTML = "";
            }
            if (doctorId <= 0 || doctorId == NaN) {
                document.getElementById("doctorIdErrorMsg").innerHTML = "Please Select a Doctor";
                return false;
            } else {
                document.getElementById("doctorIdErrorMsg").innerHTML = "";
            }
            if (totalAmount <= 0 || totalAmount == NaN || totalAmount == "") {
                document.getElementById("totalAmountErrorMsg").innerHTML = "Please Give the Price.";
                return false;
            } else {
                document.getElementById("totalAmountErrorMsg").innerHTML = "";
            }
        }
    </script>
</body>

</html>