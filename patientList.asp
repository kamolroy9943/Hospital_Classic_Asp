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
    name=Request.Form("name")
    address=Request.Form("address")
    fromAge=Request.Form("fromAge")
    toAge=Request.Form("toAge")

    pageNo = Request.Form("hidden")
    response.write pageNo
    if(pageNo="")then 
        pageNo=1
    End If

    Dim objConn, objRS, sqlString
    set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    
    set objRS = Server.CreateObject("ADODB.Recordset")
    
    dim where 
    sqlString = "Select * From Patient "
    if name<>"" Then
        where = where  + "Where Name Like '"&name&"%' "
    End If
    
    if address <> "" Then
        if instr(where, "where")<0 Then
            where = where  + "Where Address Like '"&address&"%' " 
        else
            where = where  + "AND Address Like '"&address&"%' "
        End If       
        
    End If

    if fromAge <>"" Then
        if instr(where, "where")<0 Then
            where = where  + "WHERE Age >="&fromAge&""
        else
            where = where  + "And Age >="&fromAge&""
        End If            
    End If
    
    if toAge <>"" Then
        if instr(where, "where")<0 Then
            where = where  + "Where Age <= "&toAge&""
        else
            where = where  + "AND Age <= "&toAge&""
        End If
    End If    
    
    sqlString=sqlString+where

    
    
    
    objRS.Open sqlString, objConn
    If objRS.EOF = false Then

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
    End if
%>
    <div class="container">
        <div class="row">
            <form action="patientList.asp" method="POST" id="search">
                <input type="hidden" name="hidden" id="hidden">
                <div class="float-right mb-2 mt-5" style="display:flex">
                    <div class="mr-2">
                        <strong>PatientName: </strong>
                        <input type="text" name="name" id="name" value="<%=name%>">
                    </div>
                    <div class="mr-2">
                        <strong>Address:</strong>
                        <input type="text" name="address" id="address" value="<%=address%>">
                    </div>
                    <div class="mr-2">
                        <strong>From Age: </strong>
                        <input type="number" name="fromAge" id="fromDate" value="<%=fromAge%>">
                    </div>
                    <div class="mr-2">
                        <strong>ToAge: </strong>
                        <input type="number" name="toAge" id="toDate" value="<%=toAge%>">
                    </div>
                    <button class="btn btn-primary">Search</button>
                </div>
            </form>
            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th></th>
                    <th><button type="button" name="multipleDeleteButton" id="multipleDeleteButton" class="btn btn-danger">Delete</button></th>
                    <th>Patient Name</th>
                    <th>Age</th>
                    <th>Phone No</th>
                    <th>Address</th>
                    <th></th>

                </thead>
                <%For i=startIndex to endIndex%>

                <tr id="<%=aResults(0,i)%>">
                    <td>
                        <%=i+1%>
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

                    <td> <a href='editPatient.asp?Id=<%=aResults(0,i)%>'>Edit</a></td>
                </tr>
                <%
			Next
			
			%>
            </table>

            <nav aria-label="...">
                <ul class="pagination">
                    <% For i=1 to totalPageNumber %>
                    <li class="page-item"><a class="page-link" onclick="javascript:gopage(<%=i%>)">
                            <%=i%></a></li>
                    </li>
                    <% next %>
                </ul>
            </nav>
        </div>
    </div>

    '
    <!-- href="patientList.asp?page=<%=i%>" -->


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
                    url: 'multipleDeletePatient.asp',
                    success: function (data) {
                        for (i = 0; i < values.length; i++) {
                            $("#" + values[i]).remove();
                        }
                    }
                });
            }
        })
        $(".page-link").click(function () {
            var page = $(this).text();
            $("#hidden").val(page);
            //alert( $("#hidden").val())
            $("#search").submit();
        })


    </script>
</body>

</html>