<% Sub Template %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="index.asp">Modern Hospital</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
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
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>
<div>
    <div id="mySidenav" class="sidenav">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a href="addTestForm.asp">Test Add</a>
        <a href="testList.asp">View Test List</a>
        <a href="patientAddForm.asp">Add Patient</a>
        <a href="patientList.asp">Patient List</a>
        <a href="patientTestAddForm.asp">Add Patient Test</a>
        <a href="doctorAddForm.asp">Add Doctor</a>
        <a href="doctorList.asp">Doctor List</a>
        <a href="patientTestAddForm.asp">Add Test To Patient</a>
    </div>
    <h2 class="text-center mt-5 text-uppercase">Welcome to Modern Hospital</h2>
        <span style="font-size: 41px;cursor:pointer;position:  absolute;margin-top: -105px;" onclick="openNav()">&#9776;</span>
</div>

<% End Sub %>