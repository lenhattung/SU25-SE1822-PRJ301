<%--
    Document   : login
    Created on : May 23, 2025, 9:50:21 AM
    Author     : tungi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            body {
                background-color: #f8f9fa; /* Light gray background */
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh; /* Full viewport height */
                margin: 0;
            }
            .login-container {
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 8px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }
            .login-container h2 {
                margin-bottom: 25px;
                color: #343a40;
                font-weight: 600;
            }
            .form-label {
                font-weight: 500;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                font-weight: 600;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }
            .text-danger {
                font-weight: 500;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:redirect url="welcome.jsp"/>
            </c:when>
            <c:otherwise>
                <div class="login-container text-center">
                    <h2>Login</h2>
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="login"/>
                        <div class="mb-3 text-start">
                            <label for="userID" class="form-label">UserID</label>
                            <input type="text" class="form-control" id="userID" name="strUserID" required>
                        </div>
                        <div class="mb-3 text-start">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="strPassword" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-3">Login</button>
                    </form>
                    <c:if test="${not empty requestScope.message}">
                        <p class="text-danger">${requestScope.message}</p>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>