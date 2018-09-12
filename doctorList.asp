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

    <div class="container">
        <div class="row">
            <div class="mb-3" style="display: flex;float:right; margin:0px auto 0px auto;">
                <strong>Find By Specialization: </strong>
                <select class="form-control mt-2 ml-3" name="speciality" id="speciality">

                    <% set conn=Server.CreateObject("ADODB.Connection")
                    conn.Provider="Microsoft.Jet.OLEDB.4.0"
                    conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"

                    set rs=Server.CreateObject("ADODB.recordset")
                    rs.Open "Select Id,Specialization FROM Doctor", conn
                    Do While Not rs.EOF %>
                    <option value='<%=rs("Specialization")%>'>
                        <%=rs("Specialization")%>
                    </option>
                    <% 
                   rs.MoveNext
                    Loop
                    rs.Close
                    conn.Close %>
                </select>
            </div>
            <table id="myTable" class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th>Doctor Name</th>
                    <th>Email</th>
                    <th>Phone No</th>
                    <th>Specialization</th>
                    <th></th>
                    <th></th>
                </thead>
               
            </table>

        </div>
    </div>
    <script>
        function deleteConfirm() {
            return confirm('Do you really want to delete this location?');
        }

        $("#speciality").change(function () {
            value = $("#speciality").val();
            console.log(value)

            $.ajax({
                url: "populatedoctorList.asp?value="+value,
                success: function (data, status) {
                    //data.forEach(element => {
                        $("#myTable > tbody").append(data.responseText);
                    //});
                    
                }
            });
        })
    </script>
</body>

</html>