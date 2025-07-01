<%--
    Document   : welcome.jsp
    Created on : May 23, 2025, 7:40:45 AM
    Author     : tungi
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="currentUser" value="${sessionScope.user}" />
<c:set var="isLoggedIn" value="${not empty currentUser}" />
<c:set var="isAdmin" value="${currentUser.roleID eq 'AD'}" />
<c:set var="keyword" value="${requestScope.keyword}" />
<c:set var="productList" value="${requestScope.list}" />
<c:set var="hasKeyword" value="${not empty keyword}" />
<c:set var="hasProducts" value="${not empty productList}" />
<c:set var="productCount" value="${fn:length(productList)}" />
<c:set var="keywordParam" value="${hasKeyword ? keyword : ''}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
        <%@include file="header.jsp" %>
        <style>
            body {
                background-color: #f8f9fa; /* Light gray background */
            }
            .main-content-container {
                margin-top: 20px;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }
            .search-section .search-form {
                display: flex;
                gap: 10px;
            }
            .search-section .search-input {
                flex-grow: 1;
            }
            .add-product-btn {
                margin-top: 20px;
                display: inline-block;
                padding: 10px 20px;
                background-color: #28a745; /* Green for add button */
                color: white;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }
            .add-product-btn:hover {
                background-color: #218838;
            }
            .table-container {
                overflow-x: auto; /* For responsive tables */
                margin-top: 20px;
            }
            .table {
                width: 100%;
                margin-bottom: 1rem;
                color: #212529;
                border-collapse: collapse;
            }
            .table thead th {
                vertical-align: bottom;
                border-bottom: 2px solid #dee2e6;
                padding: 0.75rem;
                text-align: left;
            }
            .table tbody td {
                padding: 0.75rem;
                vertical-align: top;
                border-top: 1px solid #dee2e6;
            }
            .table-hover tbody tr:hover {
                background-color: rgba(0,0,0,.075);
            }
            .price {
                font-weight: bold;
                color: #007bff;
            }
            .status-true {
                color: #28a745; /* Green for active */
                font-weight: 500;
            }
            .status-false {
                color: #dc3545; /* Red for inactive */
                font-weight: 500;
            }
            .action-buttons {
                display: flex;
                gap: 5px;
            }
            .edit-btn, .delete-btn {
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
                font-size: 0.9em;
                transition: background-color 0.3s ease;
            }
            .edit-btn {
                background-color: #ffc107; /* Yellow for edit */
                color: #333;
            }
            .edit-btn:hover {
                background-color: #e0a800;
            }
            .delete-btn {
                background-color: #dc3545; /* Red for delete */
            }
            .delete-btn:hover {
                background-color: #c82333;
            }
            .no-results {
                margin-top: 20px;
                font-size: 1.1em;
                color: #6c757d;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not isLoggedIn}">
                <c:redirect url="MainController"/>
            </c:when>
            <c:otherwise>
                <div class="container main-content-container">
                    <h1 class="mb-4">Welcome ${currentUser.fullName}!</h1>

                    <div class="search-section mb-4">
                        <label for="searchKeyword" class="form-label">Search by name:</label>
                        <form action="ProductController" method="post" class="search-form">
                            <input type="hidden" name="action" value="searchProduct"/>
                            <input type="text" id="searchKeyword" name="keyword" value="${keywordParam}"
                                   class="form-control search-input" placeholder="Enter product name..."/>
                            <button type="submit" class="btn btn-primary search-btn">Search</button>
                        </form>
                    </div>

                    <c:if test="${isAdmin}">
                        <a href="productForm.jsp" class="btn btn-success add-product-btn mb-4">Add New Product</a>
                    </c:if>

                    <c:choose>
                        <c:when test="${hasProducts and productCount == 0}">
                            <div class="alert alert-info no-results" role="alert">
                                No products have names that match the keyword!
                            </div>
                        </c:when>
                        <c:when test="${hasProducts and productCount > 0}">
                            <div class="table-responsive table-container">
                                <table class="table table-hover table-bordered">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Size</th>
                                            <th>Status</th>
                                            <c:if test="${isAdmin}">
                                                <th>Action</th>
                                            </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${productList}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${product.description}</td>
                                                <td class="price">VND ${product.price}</td>
                                                <td>${product.size}</td>
                                                <td class="${product.status ? 'status-true' : 'status-false'}">
                                                    ${product.status ? 'Active' : 'Inactive'}
                                                </td>
                                                <c:if test="${isAdmin}">
                                                    <td>
                                                        <div class="action-buttons">
                                                            <form action="MainController" method="post" class="d-inline">
                                                                <input type="hidden" name="action" value="editProduct"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                <button type="submit" class="btn btn-warning btn-sm edit-btn">Edit</button>
                                                            </form>

                                                            <form action="MainController" method="post" class="d-inline delete-form">
                                                                <input type="hidden" name="action" value="changeProductStatus"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="strKeyword" value="${keywordParam}" />
                                                                <button type="submit" class="btn btn-danger btn-sm delete-btn"
                                                                        onclick="return confirm('Are you sure you want to change status of this product? This will make it unavailable!')">Delete</button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                             <div class="alert alert-info no-results" role="alert">
                                No products available. Start by adding new products!
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:otherwise>
        </c:choose>
        <%@include file="footer.jsp" %>
    </body>
</html>