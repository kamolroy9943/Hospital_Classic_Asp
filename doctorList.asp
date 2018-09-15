<!--#include file="template.asp" -->
<!--#include file="function.asp" -->
<!--#include file="populatedoctorList.asp" -->
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
        <div class="p-2 float-right" style="display :flex">
            <strong>Specialization:</strong>
            <select class="form-control" name="speciality" id="speciality" style="    margin-top: -5px;">
                <option value="">All Doctors</option>
                <%
                set conn=Server.CreateObject("ADODB.Connection")
                conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    

                set rs=Server.CreateObject("ADODB.recordset")
                rs.Open "Select Specialization FROM Doctor", conn

                Do While Not rs.EOF
            %>
                <option value='<%=rs("Specialization")%>'>
                    <%=rs("Specialization")%>
                </option>
                <%
                rs.movenext
                Loop
                rs.close
            %>
            </select>
        </div>
        <table id="myTable" class="table table-border table-hover table-striped">
            <% call DoctorList %>
        </table>
        <script>
            (function () {
                if ($("input:checkbox:checked").length <= 0)
                    $("#multipleDeleteButton").prop('disabled', true);
            })()
            function EnableDeleteButton() {
                if ($("input:checkbox:checked").length > 0)
                    $("#multipleDeleteButton").prop('disabled', false);
                else
                    $("#multipleDeleteButton").prop('disabled', true);
            }
            $("#multipleDeleteButton").click(function () {
                if (!confirm("Are you sure that you want to delete all the records?"))
                    return;
                else {
                    var values = (function () {
                        var a = [];
                        $(".checkbox:checked").each(function () {
                            a.push(this.value);
                        });
                        return a;
                    })()

                    var param = "";

                    for (i = 0; i < values.length; i++) {
                        if (i != values.length) {
                            param = param + values[i] + ",";
                        }
                    }
                    var newStr = param.slice(0, param.length - 1);

                    console.log(newStr)

                    $.ajax({
                        method: 'GET',
                        data: {
                            'data': newStr
                        },
                        url: 'multipleDeleteDoctor.asp',
                        success: function (data) {
                            for (i = 0; i < values.length; i++) {
                                $("#" + values[i]).remove();
                            }
                        }
                    });
                }
            })
            $("#speciality").change(function () {
                value = $("#speciality").val();
                $.ajax({
                    method: 'GET',
                    url: 'doctorListBySpeciality.asp?value=' + value,
                    success: function (data) {
                        $("#myTable").html(data)
                    }
                })
            });
        </script>
</body>

</html>