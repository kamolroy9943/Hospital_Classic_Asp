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
<%
        dim query
        pageNo = Request.QueryString("page")
        if(pageNo="")then 
            pageNo=1
        End If

        Dim objConn, objRS, sqlString

        set objConn = Server.CreateObject("ADODB.Connection")
        objConn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= C:\inetpub\wwwroot\hospital\hospital.mdb"
        set objRS = Server.CreateObject("ADODB.Recordset")
        sqlString = "SELECT * FROM Test"
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

<body>

    <div>
        <% call Template %>
    </div>

    <div class="container">
        <div class="row">
            <table class="table table-border table-hover table-striped">
                <thead class="thead-dark">
                    <th><button type="button" name="multipleDeleteButton" id="multipleDeleteButton" class="btn btn-danger">Delete</button></th>
                    <th>Test Name</th>
                    <th>Test Type</th>
                    <th>Unit Price</th>
                    <th>Description</th>
                    <th></th>
                    <th></th>
                </thead>
                <%For i=startIndex to endIndex%>

                <tr>
                    <td><%=i%></td>
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
                    <td> <a href="#">Edit</a></td>
                    <td><a href="#" id="delete_record">Delete</a></td>
                </tr>
                <%
			Next
			
			%>
            </table>
            <nav aria-label="...">
                <ul class="pagination">
                    <% For i=1 to totalPageNumber %>
                    <li class="page-item"><a class="page-link" href="testList2.asp?page=<%=i%>">
                            <%=i%></a></li>
                    </li>
                    <% next %>
                </ul>
            </nav>
        </div>
    </div>
</body>

</html>