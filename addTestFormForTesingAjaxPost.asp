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



    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>

    <div>
        <% call Template %>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto ">
                <div class="card">
                    <div class="card-header bg-primary">ADD YOUR TEST</div>
                    <hr>
                    <label for="" class=".text-success font-weight-bold" id="successMsg"></label>
                    <div class="card-body">
                        <form>
                            <input type="hidden" id="fileName" value="<%=fileName%>">
                            <div class="form-group">
                                <input type="hidden" value="1" id="hidden" name="hidden">
                            </div>
                            <div class="form-group">
                                <label for="testName">Test Name:</label>
                                <input type="text" class="form-control" value="<%=testName%>" id="testName" name="testName"
                                    placeholder="Enter Test Name.">
                                <label class="text-danger" for="testName" name="testNameErrorMsg" id="testNameErrorMsg">
                                    <%=testError%></label>
                            </div>
                            <div class="form-group">
                                <label for="typeName">Test Type:</label>
                                <input type="text" class="form-control" value="<%=testType%>" id="testType" name="testType"
                                    placeholder="Enter Test Type.">
                                <label class="text-danger" for="typeName" name="typeNameErrorMsg" id="typeNameErrorMsg">
                                    <%=typeError%></label>
                            </div>
                            <div class="form-group">
                                <label for="unitPrice">Unit Price:</label>
                                <input type="number" class="form-control" value="<%=unitPrice%>" id="unitPrice" name="unitPrice"
                                    placeholder="Enter the price">
                                <label class="text-danger" for="unitPrice" name="unitPriceErrorMsg" id="unitPriceErrorMsg">
                                    <%=priceError%></label>
                            </div>

                            <div class="form-group">
                                <label for="Date">Date:</label>
                                <input type="text" class="form-control" id="date" name="date">
                                <label class="text-danger" for="date" name="dateError" id="dateError">
                                    <%=dateError%></label>
                            </div>

                            <div class="inline">
                              <button id="submitButton" class="btn btn-success">Submit</button>
                                <a href="testList.asp" class="btn btn-info">View Test List</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#submitButton").click(function () {

            var testName = document.getElementById("testName").value;
            var testType = document.getElementById("testType").value;
            var unitPrice = document.getElementById("unitPrice").value;
            var date = document.getElementById("date").value;

            if (testName == null || testName == "") {
                document.getElementById("testNameErrorMsg").innerHTML = "Please fill up the TestName";
                return false;
            } else {
                document.getElementById("testNameErrorMsg").innerHTML = "";
            }

            if (testType == null || testType == "") {
                document.getElementById("typeNameErrorMsg").innerHTML = "Please fill up the Test Type";
                return false;
            } else {
                document.getElementById("typeNameErrorMsg").innerHTML = "";
            }
            if (unitPrice == null || unitPrice == "") {
                document.getElementById("unitPriceErrorMsg").innerHTML = "Please fill up the Unitprice";
                return false;
            } else {
                document.getElementById("unitPriceErrorMsg").innerHTML = "";
            }
            $.ajax({
                type: "POST",
                data: {
                    "testName": testName,
                    "testType": testType,
                    "unitPrice": unitPrice,
                    "date":date,
                    "hidden": "1"
                },
                url: "ajax.asp",
                success: function () {
                    // location.href = "testList.asp";
                }, error: function () {

                }
            });
        })

        $(function () {
            $("#date").datepicker();
            $('#date').datepicker('setDate', new Date());

        });

    </script>
</body>

</html>