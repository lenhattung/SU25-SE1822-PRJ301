<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:12:10 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String userID = request.getAttribute("userID")+"";
        %>
        <h1>Welcome <%= userID %> ! </h1>
    </body>
</html>
