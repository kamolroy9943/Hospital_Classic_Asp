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
    <%
    dim query
    pageNo = Request.QueryString("page")
    searchValue = Request.Form("search")   

    if(pageNo="")then 
        pageNo=1
    End If

    Dim objConn, objRS, sqlString

    set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= C:\inetpub\wwwroot\hospital\hospital.mdb"
    set objRS = Server.CreateObject("ADODB.Recordset")

    if(searchValue = "") Then
         sqlString= "Select * FROM Test"
    Else 
         sqlString= "SELECT * FROM Test WHERE TestName LIKE '"&searchValue&"%'"
    End If     
    
    objRS.Open sqlString, objConn
    aResults = objRS.GetRows()
    objRS.Close
    objConn.Close
    totalRows = Ubound(aResults,2)+1
    rowPerPage=5
    totalPageNumber= totalRows/rowPerPage
    modevalue=  totalRows mod rowPerPage
    if modevalue > 0 then 
        totalPageNumber= Int(totalPageNumber) + 1
    end if   
    
    startIndex=(rowPerPage*pageNo)-rowPerPage
    endIndex=(rowPerPage*pageNo)-1
    If endIndex>Ubound(aResults,2) Then
        endIndex=Ubound(aResults,2)
    End if
%>
    <div>
        <% call Template %>
        <input type="hidden" id="fileName" value="<%=fileName%>">
    </div>

    <div class="container">
        <div class="row">
            <div class="pb-2 float-right">
                <form method="POST" action="testList.asp">
                    <input type="text" name="search" id="search" value="" placeholder="Search">
                    <input type="submit" name="submit" value="Search">
                </form>
            </div>

            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th></th>
                    <th><button type="button" name="multipleDeleteButton" id="multipleDeleteButton" class="btn btn-danger">Delete</button></th>
                    <th>Test Name</th>
                    <th>Test Type</th>
                    <th>Unit Price</th>
                    <th>Date</th>
                    <th></th>
                    <th></th>
                </thead>
                <%For i=startIndex to endIndex%>

                <tr id="<%=aResults(0,i)%>">
                    <td>
                        <%=i%>
                    </td>
                    <td><input name='checkbox' class='checkbox' type='checkbox' value="<%=aResults(0,i)%>" onclick="return EnableDeleteButton()"></td>
                    <td>
                        <%Response.Write(aResults(1,i))%>
                    </td>
                    <td>
                        <%Response.Write(aResults(2,i))%>
                    </td>
                    <td>
                        <%Response.Write(aResults(3,i))%>
                    </td>
                    <td>
                        <%Response.Write(aResults(4,i))%>
                    </td>
                    
                    <td> <a href='editTest.asp?Id=<%=aResults(0,i)%>'>Edit</a></td>
                </tr>
                <%
			Next
			
			%>
            </table>

            <nav aria-label="...">
                <ul class="pagination">
                    <% For i=1 to totalPageNumber %>
                    <li class="page-item"><a class="page-link" href="testList.asp?page=<%=i%>">
                            <%=i%></a></li>
                    </li>
                    <% next %>
                </ul>
            </nav>



        </div>
    </div>
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

        var value = $("#fileName").val();
        if (value == "testList.asp") {
            $("#testList").css('background', 'green');
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
    </script>
</body>

</html>