<%--
    Document   : header.jsp
    Created on : July 1, 2025, 11:30:00 AM
    Author     : Gemini
    Description: Combined header and navigation menu using Bootstrap 5.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<style>
    .navbar {
        background-color: #343a40 !important; /* Màu nền tối cho navbar */
        padding: 0.8rem 1.5rem; /* Giảm padding một chút để gọn hơn */
    }
    .navbar-brand {
        font-weight: bold;
        color: #fff !important;
        font-size: 1.5rem; /* Kích thước lớn hơn cho tên hệ thống */
    }
    .welcome-text {
        color: #f8f9fa; /* Màu chữ sáng cho thông báo chào mừng */
        margin-right: 15px;
        font-weight: 500;
    }
    .nav-link {
        color: #dee2e6 !important; /* Màu chữ cho các liên kết điều hướng */
        font-weight: 500;
        transition: color 0.3s ease, background-color 0.3s ease;
    }
    .nav-link:hover {
        color: #fff !important;
        background-color: rgba(255, 255, 255, 0.1); /* Hiệu ứng hover nhẹ */
        border-radius: 5px;
    }
    .btn-outline-light {
        border-color: #f8f9fa;
        color: #f8f9fa;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    .btn-outline-light:hover {
        background-color: #f8f9fa;
        color: #343a40;
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
</style>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="welcome.jsp">Product Management System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="welcome.jsp">Home</a>
                </li>
                <c:set var="currentUser" value="${sessionScope.user}" />
                <c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />

                <c:if test="${isAdmin}">
                    <li class="nav-item">
                        <a class="nav-link" href="productForm.jsp">Add Product</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">User Management</a> <%-- Example link --%>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="#">About Us</a> <%-- Example link --%>
                </li>
            </ul>

            <ul class="navbar-nav">
                <c:set var="isLoggedIn" value="${not empty currentUser}" />

                <c:if test="${isLoggedIn}">
                    <li class="nav-item d-flex align-items-center me-3">
                        <span class="welcome-text">Welcome, <strong>${currentUser.fullName}!</strong></span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-light" href="MainController?action=logout">Logout</a>
                    </li>
                </c:if>
                <c:if test="${not isLoggedIn}">
                    <li class="nav-item">
                        <a class="btn btn-primary" href="MainController">Login</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>