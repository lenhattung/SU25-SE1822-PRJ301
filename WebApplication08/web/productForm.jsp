<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO" %>
<%@page import="model.ProductDTO" %>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Form</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
                color: #333;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background: white;
                border-radius: 12px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .header {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                color: white;
                text-align: center;
                padding: 30px;
                margin-bottom: 0;
            }

            .header h1 {
                font-size: 2.2em;
                font-weight: 300;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .form-container {
                padding: 40px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #555;
                font-size: 14px;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e1e5e9;
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s ease;
                background-color: #fafbfc;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            textarea:focus {
                outline: none;
                border-color: #4facfe;
                background-color: white;
                box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
                font-family: inherit;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 25px;
            }

            input[type="checkbox"] {
                width: 20px;
                height: 20px;
                accent-color: #4facfe;
                cursor: pointer;
            }

            .checkbox-group label {
                margin-bottom: 0;
                cursor: pointer;
                font-weight: 500;
            }

            .button-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            input[type="submit"],
            input[type="reset"] {
                flex: 1;
                padding: 14px 24px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            input[type="submit"] {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            input[type="reset"] {
                background: #f8f9fa;
                color: #6c757d;
                border: 2px solid #e9ecef;
            }

            input[type="reset"]:hover {
                background: #e9ecef;
                transform: translateY(-1px);
            }

            .error-message {
                background: #fee;
                color: #c53030;
                padding: 12px 16px;
                border-radius: 6px;
                margin: 20px 0;
                border-left: 4px solid #fc8181;
                font-size: 14px;
            }

            .success-message {
                background: #f0fff4;
                color: #38a169;
                padding: 12px 16px;
                border-radius: 6px;
                margin: 20px 0;
                border-left: 4px solid #68d391;
                font-size: 14px;
            }

            .access-denied {
                text-align: center;
                padding: 60px 40px;
                color: #e53e3e;
                font-size: 18px;
                font-weight: 500;
            }

            .access-denied::before {
                content: "🚫";
                display: block;
                font-size: 48px;
                margin-bottom: 20px;
            }

            .required {
                color: #e53e3e;
                font-weight: bold;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    margin: 10px;
                    border-radius: 8px;
                }

                .form-container {
                    padding: 20px;
                }

                .header {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 1.8em;
                }

                .button-group {
                    flex-direction: column;
                }

                input[type="submit"],
                input[type="reset"] {
                    width: 100%;
                }
            }

            /* Animation for form appearance */
            .form-container {
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% if (AuthUtils.isAdmin(request)){
            
            String checkError = (String)request.getAttribute("checkError");
            String message = (String)request.getAttribute("message");
            ProductDTO product  = (ProductDTO)request.getAttribute("product");
            %>
            
            <div class="header">
                <h1>PRODUCT FORM</h1>
            </div>
            
            <div class="form-container">
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="addProduct"/>
                    
                    <div class="form-group"> 
                        <label for="id">ID <span class="required">*</span></label> 
                        <input type="text" id="id" name="id" required="required"
                               value="<%=product!=null?product.getId():""%>" />
                    </div>
                    
                    <div class="form-group"> 
                        <label for="name">Name <span class="required">*</span></label> 
                        <input type="text" id="name" name="name" required="required"
                               value="<%=product!=null?product.getName():""%>"/>
                    </div>
                    
                    <div class="form-group"> 
                        <label for="image">Image URL</label> 
                        <input type="text" id="image" name="image"
                               value="<%=product!=null?product.getImage():""%>"/>
                    </div>
                    
                    <div class="form-group"> 
                        <label for="description">Description</label> 
                        <textarea id="description" name="description" 
                                  placeholder="Enter product description..."><%=product!=null?product.getDescription():""%></textarea>
                    </div>
                    
                    <div class="form-group"> 
                        <label for="price">Price <span class="required">*</span></label> 
                        <input type="number" id="price" name="price" required="required" 
                               min="0" step="0.01" placeholder="0.00"
                               value="<%=product!=null?product.getPrice():""%>"/>
                    </div>
                    
                    <div class="form-group"> 
                        <label for="size">Size</label> 
                        <input type="text" id="size" name="size" placeholder="e.g., S, M, L, XL"
                               value="<%=product!=null?product.getSize():""%>"/>
                    </div>
                    
                    <div class="checkbox-group"> 
                        <input type="checkbox" id="status" name="status" value="true"
                               <%=product!=null&&product.isStatus()?" checked='checked' ":""%> />
                        <label for="status">Active Product</label> 
                    </div>
                    
                    <div class="button-group"> 
                        <input type="submit" value="Add Product"/>
                        <input type="reset" value="Reset"/>    
                    </div>
                </form>
                
                 <% if(checkError != null && !checkError.isEmpty()) { %>
                    <div class="error-message"><%=checkError%></div>
                <% } else if(message != null&& !message.isEmpty()) { %>
                    <div class="success-message"><%=message%></div>
                <% } %>
            </div>
            
            <%
        }else {
            %>
            <div class="header">
                <h1>ACCESS DENIED</h1>
            </div>
            <div class="access-denied">
                <%=AuthUtils.getAccessDeniedMessage("Product Form")%> 
            </div>
            <%
        }
            %>
        </div>
    </body>
</html>