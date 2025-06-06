<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Form</title>
    </head>
    <body>
        <% if (AuthUtils.isAdmin(request)){
            %>
             HTML FORM
            <%
        }else {
            %>
             <%=AuthUtils.getAccessDeniedMessage("Product Form")%> 
            <%
        }
        %>
    </body>
</html>
