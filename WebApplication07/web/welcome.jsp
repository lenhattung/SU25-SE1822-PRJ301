<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:12:10 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
          if(AuthUtils.isLoggedIn(request)){
             UserDTO user = AuthUtils.getCurrentUser(request);
        %>
        <h1>Welcome <%= user.getFullName() %> ! </h1>
        <a href="MainController?action=logout">Logout</a>
        <%} else { %>
            <%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%> <br/>
            (Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
        <%}%>
    </body>
</html>
