<!--#include file="function.asp" -->
<!--#include file="populatedoctorList.asp" -->

<%
    fileName = getFileName()
%>


<% Sub Template %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="index.asp">Modern Hospital</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    Test
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="addTestForm.asp">Add Test</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
        </ul>
        <div>
            <div class="dropdown mr-5">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    Welcome
                    <%=Request.Cookies("username")%>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="logout.asp">LogOut</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<div>
    <div id="mySidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a id="testAddForm" href="addTestForm.asp" <%if instr(fileName, "addTestForm" ) > 0 then %> style="background: green;" <%End if%> >Test Add</a>
        <a id="testList" href="testList.asp" <%if instr(fileName, "testList" ) > 0 then %> style="background: green;" <%End if%>>View Test List</a>
        <a id="addPatientForm" href="addPatientForm.asp" <%if instr(fileName, "addPatientForm" ) > 0 then %> style="background: green;" <%End if%>>Add Patient</a>
        <a id="patientList" href="patientList.asp" <%if instr(fileName, "patientList" ) > 0 then %> style="background: green;" <%End if%>>Patient List</a>
        <a href="patientTestAddForm.asp" <%if instr(fileName, "patientTestAddForm" ) > 0 then %> style="background: green;" <%End if%>>Add Patient Test</a>
        <a href="addDoctorFrom.asp" <%if instr(fileName, "addDoctorFrom" ) > 0 then %> style="background: green;" <%End if%>>Add Doctor</a>
        <a href="doctorList.asp" <%if instr(fileName, "doctorList" ) > 0 then %> style="background: green;" <%End if%>>Doctor List</a>
    </div>
    <h2 class="text-center mt-5 text-uppercase">Welcome to Modern Hospital</h2>
    <span style="font-size: 41px;cursor:pointer;position:  absolute;margin-top: -105px;" onclick="openNav()">&#9776;</span>
</div>
<% End Sub %>