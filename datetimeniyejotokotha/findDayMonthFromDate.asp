<%
    'mainString= "2018-09-19T05:53:23.082+0000"
    'positionOfDot = instr(mainString,".")
    'stringWihoutDotPart= Left(mainString,positionOfDot-1)
    'finalFormate= Replace(stringWihoutDotPart,"T"," ")
    'lol = FormatDateTime(finalFormate)
    'response.write lol





    mainString = "2018-09-23 13:46:00"
    myDateTime = FormatDateTime(mainString)
    monthNumber= DatePart("m",myDateTime)
    nameOfMonth = monthName(monthNumber)
    desireDate = day (myDateTime)
    shortNameOfMonth= left(nameOfMonth,3)
    myTimeWithSecond = FormatDateTime(myDateTime,3)
    myTimeWithoutSecond = FormatDateTime(myTimeWithSecond, vbShortTime)
    dateAndMonth = desireDate & " "& shortNameOfMonth & " " & myTimeWithoutSecond
    response.write dateAndMonth




    'response.write realDate
    'desireDate = day (realDate)
    'desireMonth=  month(realDate)
    'nameOfMonth = monthName(desireMonth)
    'shortFormat= left(nameOfMonth,3)
    'desireFormate = desireDate & " " & shortFormat
    'response.write desireFormate






%>





 