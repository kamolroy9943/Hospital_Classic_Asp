<!--#include file="function.asp" -->
<!--#include file="template.asp" -->


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

            <div class="pb-2 float-right">
                <form method="POST" action="testList.asp">
                    <input type="hidden" id="fileName" value="<%=fileName%>">
                    <input type="text" name="search" id="search" value="" placeholder="Search">
                    <input type="submit" name="submit" value="Search">
                </form>
            </div>

            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th><button type="button" name="multipleDeleteButton" id="multipleDeleteButton" class="btn btn-danger">Delete</button></th>
                    <th>Test Name</th>
                    <th>Test Type</th>
                    <th>Unit Price</th>
                    <th></th>
                    <th></th>
                    <th></th>
                </thead>
                <%
                    dim query

                    searchValue = Request.Form("search")   

                    set conn=Server.CreateObject("ADODB.Connection")
                    conn.Provider="Microsoft.Jet.OLEDB.4.0"
                    conn.Open "C:\inetpub\wwwroot\hospital\hospital.mdb"
            
                    set rs=Server.CreateObject("ADODB.recordset")
                    if(searchValue = "") Then
                        query= "Select * FROM Test"
                    Else 
                        query= "SELECT * FROM Test WHERE TestName LIKE '"&searchValue&"%'"
                    End If

                    rs.Open query, conn
            
                    Do While Not rs.EOF
                            id=rs("Id")
                            response.write "<tr id="&id&"><td><input name='checkbox' class='checkbox' type='checkbox' value="&id&"></td>"                            
                            response.write "<td>" & rs("TestName") & "</td>"
                            response.write "<td>" & rs("Type") & "</td>"
                            response.write "<td>" & rs("UnitPrice") & "</td>"
                            response.write "<td><a href='editTest.asp?Id="&id&"'>Edit</a></td>"
                            response.write "<td><a onclick='return deleteConfirm()' href='deleteTest.asp?Id="&id&"'>Delete</a></td></tr>"
                    rs.MoveNext
                    Loop
                    rs.Close
                    conn.Close  
                 %>
            </table>

        </div>
    </div>
    <script>
        
            var value = $("#fileName").val();
            if(value == "testList.asp"){
                $("#testList").css('background','green');
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

                $.ajax({
                    method: 'GET',
                    data: { 'data': newStr },
                    url: 'multipleDeleteTest.asp',
                    success: function (data) {
                        for (i = 0; i < values.length; i++) {
                            $("#" + values[i]).remove();
                        }
                    }
                });
            }
        })

        function deleteConfirm() {
            return confirm('Do you really want to delete this location?');
        }



        $('#cb').change(function () {
            $("div").toggle($(this).is(':checked'));
        });
    </script>
</body>

</html>