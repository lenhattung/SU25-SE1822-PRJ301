<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:12:10 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="utils.AuthUtils" %>
<%@page import="java.util.List" %>
<%@page import="model.ProductDTO" %>
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
             String keyword = (String) request.getAttribute("keyword");
        %>
        <h1>Welcome <%= user.getFullName() %> ! </h1>
        <a href="MainController?action=logout">Logout</a>
        <hr/>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="searchProduct"/>
            Search product by name:
            <input type="text" name="keyword" value="<%=keyword!=null?keyword:""%>"/>
            <input type="submit" value="Search"/>
        </form>
        <br/>
        <%
            List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("list");
            if(list!=null && list.isEmpty()){
                %>
                No products have name match with the keyword.
                <%
            }else if(list!=null && !list.isEmpty()){
                %>
                <table>
                    <thead>
                        <th>Id</th>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Size</th>
                        <th>Status</th>
                    </thead>
                    <tbody>
                        <% for(ProductDTO p: list) { %>
                            <tr>
                                <td><%=p.getId()%></td>
                                <td><%=p.getName()%></td>
                                <td><%=p.getDescription()%></td>
                                <td><%=p.getImage()%></td>
                                <td><%=p.getPrice()%></td>
                                <td><%=p.getSize()%></td>
                                <td><%=p.isStatus()%></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <%
            }
        %>
        <%} else { %>
        <%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%> <br/>
        (Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
        <%}%>
    </body>
</html>
