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
        <h1>PRODUCT FORM</h1>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="addProduct"/>

            <div> 
                <label for="id"/> ID* </label> 
                <input type="text" id="id" name="id" required="required"/>
            </div>

            <div> 
                <label for="name"/> Name* </label> 
                <input type="text" id="name" name="name" required="required"/>
            </div>

            <div> 
                <label for="image"/> Image </label> 
                <input type="text" id="image" name="image"/>
            </div>

            <div> 
                <label for="description"/> Description </label> 
                <textarea  id="description" name="description">
                </textarea>
            </div>
            
            <div> 
                <label for="price"/> Price* </label> 
                <input type="text" id="price" name="price" required="required"/>
            </div>

            <div> 
                <label for="size"/> Size </label> 
                <input type="text" id="size" name="size"/>
            </div>
            
            <div> 
                <label for="status"/> Status (Active Product) </label> 
                <input type="checkbox" id="status" name="status"/>
            </div>
            
            <div> 
                <input type="submit" value="Add Product"/>
                <input type="reset" value="Reset"/>    
            </div>
        </form>
        <%
    }else {
        %>
        <%=AuthUtils.getAccessDeniedMessage("Product Form")%> 
        <%
    }
        %>
    </body>
</html>
