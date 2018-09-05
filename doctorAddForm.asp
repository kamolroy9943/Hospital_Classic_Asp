<!--#include file="template.asp" -->
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
                    <div class="card-header bg-primary test-upercase">ADD Doctor HERE</div>
                    <hr>
                    <div class="card-body">
                        <form action="doctorAddResponse.asp" method="POST">
                            <div class="form-group">
                                <label for="doctorName">Doctor Name:</label>
                                <input type="text" class="form-control" id="doctorName" name="doctorName" placeholder="Enter Doctor Name.">
                            </div>
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter Doctor Email.">
                            </div>
                            <div class="form-group">
                                <label for="phoneNo">Contact No:</label>
                                <input type="number" class="form-control" id="phoneNo" name="phoneNo" placeholder="Enter Doctor Phone">
                            </div>
                            <div class="form-group">
                                <label for="address">Designation:</label>
                                <input type="textarea" class="form-control" id="designation" name="designation" placeholder="Enter Doctor Designation">
                            </div>
                            <div class="inline">
                                <button type="submit" class="btn btn-success">Submit</button>
                                <a href="doctorList.asp" class="btn btn-info">View Doctor List</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

</html>