<%-- 
    Document   : login
    Created on : May 23, 2025, 9:50:21 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("user");
            if(user!=null){
                response.sendRedirect("welcome.jsp");
            }else{

                Object objMS = request.getAttribute("message");
                String msg = (objMS==null)?"":(objMS+"");
            %>
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="login"/>
                UserID : <input type="text" name="strUserID" /> <br/> 
                Password : <input type="password" name="strPassword" /> </br>
                <input type="submit" value="Login"/>
            </form>
            <span style="color: red"><%=msg%></span>

        <%}%>
    </body>
</html>
