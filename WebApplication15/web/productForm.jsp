<%--
    Document   : productForm.jsp
    Created on : May 23, 2025, 7:40:45 AM
    Author     : tungi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="model.ProductDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Form</title>
        <%@include file="header.jsp" %>
        <style>
            body {
                background-color: #f8f9fa; /* Light gray background */
            }
            .form-section-container {
                margin-top: 20px;
                padding: 30px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }
            .form-section-container h1 {
                margin-bottom: 25px;
                font-weight: 600;
                color: #343a40;
            }
            .back-link {
                display: inline-block;
                margin-bottom: 20px;
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .form-group label .required {
                color: #dc3545; /* Red for required asterisk */
                margin-left: 3px;
            }
            .checkbox-group {
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }
            .checkbox-group input[type="checkbox"] {
                margin-right: 8px;
                transform: scale(1.2); /* Make checkbox slightly larger */
            }
            .button-group {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }
            .button-group input[type="submit"],
            .button-group input[type="reset"] {
                flex: 1;
                padding: 10px 15px;
                border-radius: 5px;
                border: none;
                cursor: pointer;
                font-size: 1.05em;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }
            .button-group input[type="submit"] {
                background-color: #007bff;
                color: white;
            }
            .button-group input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .button-group input[type="reset"] {
                background-color: #6c757d; /* Gray for reset */
                color: white;
            }
            .button-group input[type="reset"]:hover {
                background-color: #5a6268;
            }
            .error-message, .success-message {
                margin-top: 20px;
                padding: 15px;
                border-radius: 5px;
                font-weight: bold;
                text-align: center;
            }
            .error-message {
                background-color: #f8d7da; /* Light red */
                color: #721c24; /* Dark red text */
                border: 1px solid #f5c6cb;
            }
            .success-message {
                background-color: #d4edda; /* Light green */
                color: #155724; /* Dark green text */
                border: 1px solid #c3e6cb;
            }
            .access-denied {
                text-align: center;
                margin-top: 50px;
                padding: 30px;
                background-color: #fff3cd; /* Light yellow background */
                color: #856404; /* Dark yellow text */
                border: 1px solid #ffeeba;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>
        <div class="container form-section-container">
            <% if (AuthUtils.isAdmin(request)){

            String checkError = (String)request.getAttribute("checkError");
            String message = (String)request.getAttribute("message");
            ProductDTO product = (ProductDTO)request.getAttribute("product");
            Boolean isEdit = (Boolean)request.getAttribute("isEdit")!=null;
            String keyword = (String)request.getAttribute("keyword");
            %>

            <a href="welcome.jsp" class="back-link">← Back to Products</a>
            <h1 class="text-center"><%=isEdit ? "EDIT PRODUCT" : "ADD PRODUCT"%></h1>

            <form action="MainController" method="post">
                <input type="hidden" name="action" value="<%=isEdit ? "updateProduct" : "addProduct"%>"/>

                <div class="mb-3">
                    <label for="id" class="form-label">ID <span class="required">*</span></label>
                    <input type="text" class="form-control" id="id" name="id" required
                           value="<%=product!=null?product.getId():""%>"
                           <%=isEdit ? "readonly" : ""%> />
                </div>

                <div class="mb-3">
                    <label for="name" class="form-label">Name <span class="required">*</span></label>
                    <input type="text" class="form-control" id="name" name="name" required
                           value="<%=product!=null?product.getName():""%>"/>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">Image URL</label>
                    <input type="text" class="form-control" id="image" name="image"
                           value="<%=product!=null?product.getImage():""%>"/>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="3"
                              placeholder="Enter product description..."><%=product!=null?product.getDescription():""%></textarea>
                </div>

                <div class="mb-3">
                    <label for="price" class="form-label">Price <span class="required">*</span></label>
                    <input type="number" class="form-control" id="price" name="price" required
                           min="0" step="0.01" placeholder="0.00"
                           value="<%=product!=null?product.getPrice():""%>"/>
                </div>

                <div class="mb-3">
                    <label for="size" class="form-label">Size</label>
                    <input type="text" class="form-control" id="size" name="size" placeholder="e.g., S, M, L, XL"
                           value="<%=product!=null?product.getSize():""%>"/>
                </div>

                <div class="form-check checkbox-group">
                    <input class="form-check-input" type="checkbox" id="status" name="status" value="true"
                           <%=product!=null&&product.isStatus()?" checked='checked' ":""%> />
                    <label class="form-check-label" for="status">Active Product</label>
                </div>

                <div class="button-group">
                    <input type="hidden" name="keyword" value="<%=keyword!=null?keyword:""%>" />
                    <input type="submit" value="<%=isEdit ? "Update Product" : "Add Product"%>" class="btn btn-primary"/>
                    <input type="reset" value="Reset" class="btn btn-secondary"/>
                </div>
            </form>

            <% if(checkError != null && !checkError.isEmpty()) { %>
            <div class="alert alert-danger error-message" role="alert"><%=checkError%></div>
            <% } else if(message != null&& !message.isEmpty()) { %>
            <div class="alert alert-success success-message" role="alert"><%=message%></div>
            <% } %>

            <%
            }else {
            %>
            <div class="access-denied">
                <h1 class="text-danger">ACCESS DENIED</h1>
                <p><%=AuthUtils.getAccessDeniedMessage("Product Form")%></p>
            </div>
            <%
            }
            %>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>