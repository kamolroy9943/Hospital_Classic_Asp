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
            <div class="col-md-6 mx-auto ">
                <div class="card">
                    <div class="card-header bg-primary text-uppercase">ADD PATIENT TEST HERE</div>
                    <hr>
                    <div class="card-body">
                        <form action="pateientTestAddResponse.asp" method="POST">
                            <div class="form-group">
                                <label for="patientId">Patient:</label>
                                <select class="form-control" name="patientId" id="patientId">
                                    <option value=''>-------Select Patient-------</option>
                                    <%
                                        set conn=Server.CreateObject("ADODB.Connection")
                                        conn.Provider="Microsoft.Jet.OLEDB.4.0"
                                        conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
                                
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
                                    <option value=''>-------Select Test-------</option>
                                    <%
                                            set conn=Server.CreateObject("ADODB.Connection")
                                            conn.Provider="Microsoft.Jet.OLEDB.4.0"
                                            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
                                    
                                            set rs=Server.CreateObject("ADODB.recordset")
                                            rs.Open "Select * FROM Test", conn
                            
                                            Do While Not rs.EOF
                                                %>
                                        <option value='<%=rs("Id")%>'>
                                            <%=rs("TestName")%>
                                        </option>
                                        <%
                                                rs.movenext
                                            Loop
                                            rs.close
                                            %>
                                </select>
                                <label class="text-danger" for="testId" id="testIdErrorMsg" name="testIdErrorMsg"></label>
                            </div>
                            <div class="form-group">
                                <label for="doctorId">Refered By:</label>
                                <select class="form-control" name="doctorId" id="doctorId">
                                    <option value=''>-------Select Doctor-------</option>
                                    <%
                                            set conn=Server.CreateObject("ADODB.Connection")
                                            conn.Provider="Microsoft.Jet.OLEDB.4.0"
                                            conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
                                    
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
                                <input type="number" class="form-control" id="totalAmount" name="totalAmount" placeholder="Enter Test Amount">
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
        function CheckFormValidation(){
            var patientId = document.getElementById("patientId").value;
            var testId = document.getElementById("testId").value;
            var doctorId = document.getElementById("doctorId").value;
            var totalAmount = document.getElementById("totalAmount").value;

            if (patientId <= 0 || patientId == NaN) {
                document.getElementById("patientIdErrorMsg").innerHTML = "Please Select a Patient";
                return false;
            }else{
                document.getElementById("patientIdErrorMsg").innerHTML = "";
            }
          
           if (testId <= 0 || testId == NaN) {
                document.getElementById("testIdErrorMsg").innerHTML = "Please Select a Test";
                return false;
            }else{
                document.getElementById("testIdErrorMsg").innerHTML = "";
            }
            if(doctorId<=0 || doctorId ==NaN){
                document.getElementById("doctorIdErrorMsg").innerHTML = "Please Select a Doctor";
                return false;
            }
            else{
                document.getElementById("doctorIdErrorMsg").innerHTML = "";
            }
            if (totalAmount <=0 || totalAmount==NaN || totalAmount =="") {
                document.getElementById("totalAmountErrorMsg").innerHTML = "Please Give the Price.";
                return false;
            }else {
                document.getElementById("totalAmountErrorMsg").innerHTML = "";
            }

            // if ((testName==null || testName=="") || (testType==null || testType=="") || (unitPrice==null || unitPrice==""))
            // {
            //     alert("Please Fill All Required Field");
            //     return false;
            // }
        }
    </script>
</body>

</html>