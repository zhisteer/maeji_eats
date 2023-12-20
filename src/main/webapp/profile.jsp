<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="maeji_eats.UserDAO" %>
<%@ page import="maeji_eats.User" %>

<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Base64" %>

<%
    Integer loggedInUserId = (Integer) session.getAttribute("loggedInUserId");
    UserDAO userDAO = new UserDAO();
    User loggedInUser = null; // Initialize to null in case the attribute is not present or has an unexpected type

    if (loggedInUserId != null) {
        loggedInUser = userDAO.getUserById(loggedInUserId);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>M-Eats | Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="color.css">
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/4b5ce4bbef.js"></script>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark ml-5">
        <a class="navbar-brand" href="home.jsp">M-EATS</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav mr-5">
                <% if (loggedInUserId == null) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">로그인</a>
                    </li>
                <% } else if (loggedInUser.getUsername().equals("admin")) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="adminDashboard.jsp">Admin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp"><%= loggedInUser.getUsername() %></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </nav>

    <!-- Profile Form Section -->
        <h1 class="text-center">프로필 수정</h1>
        <form class="form-container" action="updateProfile.jsp" method="post">
            <div class="form-group">
                <label for="username">사용자 이름:</label>
                <input type="text" class="form-control" id="username" name="username" value="<%= loggedInUser.getUsername() %>" required>
            </div>
            <div class="form-group">
                <label for="password">새 비밀번호:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">전화번호:</label>
                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= loggedInUser.getPhoneNumber() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">저장</button>
        </form>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.8/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
