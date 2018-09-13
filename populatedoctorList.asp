<% Sub DoctorList 
pageNo = Request.QueryString("page")

if(pageNo="")then 
    pageNo=1
End If

Dim objConn, objRS, sqlString

set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("hospital.mdb")    
set objRS = Server.CreateObject("ADODB.Recordset")
value = Request.QueryString("value")
if(value<>"") Then 
    searchValue = value
End If
 
if(searchValue<>"") Then
    sqlString= "Select * From Doctor Where Specialization='"&searchValue&"' "
Else 
     sqlString= "Select * FROM Doctor"
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


<thead class="thead-dark">
    <th></th>
    <th><button type="button" name="multipleDeleteButton" id="multipleDeleteButton" class="btn btn-danger">Delete</button></th>
    <th>Doctor Name</th>
    <th>Email</th>
    <th>Phone No</th>
    <th>Specialization</th>
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

    <td> <a href='editDoctor.asp?Id=<%=aResults(0,i)%>'>Edit</a></td>
</tr>
<%
    Next
    
    %>


<nav aria-label="...">
    <ul class="pagination">
        <% For i=1 to totalPageNumber %>
        <li class="page-item"><a class="page-link" href="doctorList.asp?page=<%=i%>">
                <%=i%></a></li>
        </li>
        <% next %>
    </ul>
</nav>
</div>
</div>

<% End Sub %>