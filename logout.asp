<%
    session("email")=""
    Response.Cookies("email")=""
    Response.Cookies("username")=""
    Response.Redirect "login.asp"
%>